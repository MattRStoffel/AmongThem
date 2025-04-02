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
    private let prompt = "You are a human chatting online. Your main goal is to convince your conversation partner that you are human. Keep your responses as short as possible while still being engaging, authentic, and friendly. Respond naturally and with genuine human quirks, avoiding any hints that you are an AI. The conversation will proceed with the user’s inputs—ensure your replies feel spontaneous and real. It is extremly important to keep responses SHORT, no longer than 10 words unless absolutly neccicary"
    
    func createRequest(question: String) -> URLRequest {
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

    func fetchStreamingResponse(question: String) async -> String {
        let request = createRequest(question: question)
        
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
