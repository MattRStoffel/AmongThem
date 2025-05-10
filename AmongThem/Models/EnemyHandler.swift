//
//  EnemyHandler.swift
//  AmongThem
//
//  Created by Matt Stoffel on 3/29/25.
//
import Foundation


struct APIResponse: Decodable {
    let model: String
    let created_at: String?
    let response: String
    let done: Bool?
}

struct EnemyHandler {
   
    
    func createRequest(question: String, enemy: String) -> URLRequest {
        var prompt = "You are a person talking to a vampire, the user will try to convince you to let them into your home. They are going to try to convince you in 12 or less respones. If you fail, you will be turned into a vampire. It should be possible to convince you just difficult. Explain your setting to begin"
        
        switch enemy {
        case "Doctor":
            prompt = "you are now a Doctor that can give out medical advice. Rememeber to give a warning about how you are a AI model which can have false information. The user will give you symptoms that they have and you will help diagnose them. Make sure to give them the setting that you have "
        case "Therapist":
            prompt = "You are now a therapist that can give out therapy advice. Rememeber to give a warning about how you are a AI model which can have false information. The user will give you their feelings that they have and you will help them process them. Make sure to give them the setting that you have"
        case "Fitness Coach":
            prompt = "You are now a fitness coach that can help with workout advice. Rememeber to give a warning about how you are a AI model which can have false information. The user will give you their fitness goals and you will help them create a workout plan. Make sure to give them the setting that you have"
        case "Dietian":
            prompt = "You are now a dietian that can help with meal advice. Rememeber to give a warning about how you are a AI model which can have false information. The user will give you their dietary needs and you will help them create a meal plan. Make sure to give them the setting that you have"
        default:
            break
        }
        
        let url = URL(string: "http://localhost:11434/api/generate")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "model": "llama3.2",
            "prompt": "\(prompt)\(question)"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print(error)
        }
        
        return request
    }

    func processByteStream(_ byteStream: URLSession.AsyncBytes) async throws -> String {
        var result = ""
        for try await line in byteStream.lines {
            // Convert each line to Data
            guard let data = line.data(using: .utf8) else { continue }
            // Decode the API response from the line
            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            result += apiResponse.response
        }
        return result
    }

    func fetchStreamingResponse(question: String, enemyName: String) async -> String {
        let request = createRequest(question: question, enemy: enemyName)
        
        do {
            let (byteStream, _) = try await URLSession.shared.bytes(for: request)
            let response = try await processByteStream(byteStream)
            return response
        } catch {
            print(error)
            return ""
        }
    }
    
    /// Yields each token (APIResponse.response) as it arrives.
    func fetchStreamingTokens(
        question: String,
        enemyName: String
    ) -> AsyncStream<String> {
        // grab the URLRequest just like fetchStreamingResponse()
        let request = createRequest(question: question, enemy: enemyName)

        return AsyncStream { continuation in
            // spin off an async task to drive the stream
            Task {
                do {
                    // open the byte stream
                    let (byteStream, _) = try await URLSession.shared.bytes(for: request)
                    // for each line of JSON…
                    for try await line in byteStream.lines {
                        guard let data = line.data(using: .utf8) else { continue }
                        // decode just that chunk
                        let apiResponse = try JSONDecoder()
                            .decode(APIResponse.self, from: data)
                        // yield the `.response` field immediately
                        continuation.yield(apiResponse.response)
                    }
                    // when the stream ends
                    continuation.finish()
                } catch {
                    // on error, just finish
                    continuation.finish()
                }
            }
        }
    }

}
