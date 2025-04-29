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
        case "bot":
            prompt = "you are now a robot and you are convinced that the user is a person. They are trying to convince you that they are a robot as well. They are going to try to convince you in 12 or less respones. If you fail, you will be deactivated. It should be possible to convince you just difficult. Explain your setting to begin"
        case "alien":
            prompt = "you are now a alien talking in strange language"
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
}
