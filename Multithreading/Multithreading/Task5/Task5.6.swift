//
//  Task5.6.swift
//  Multithreading
//
//  Created by Tixon Markin on 23.03.2024.
//

import UIKit

final class ViewController56: UIViewController {
    var networkService = NetworkService56()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                print(try await networkService.fetchMessages())
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

final class NetworkService56 {
    enum NetworkServiceError: Error, LocalizedError {
        case emptyArrayResultError
        
        var errorDescription: String? {
            switch self {
            case .emptyArrayResultError:
                "Ну нет элементов. Пустой же масив пришел."
            }
        }
    }
    
    func fetchMessages() async throws -> [Message] {
        let url = URL(string: "https://hws.dev/user-messages.json")!
        
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let messages = try? JSONDecoder().decode([Message].self, from: data) else { return }
                
                if messages.isEmpty {
                    continuation.resume(throwing: NetworkServiceError.emptyArrayResultError)
                } else {
                    continuation.resume(returning: messages)
                }
            }.resume()
        }
    }
}
