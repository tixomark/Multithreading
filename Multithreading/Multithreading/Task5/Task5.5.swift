//
//  Task5.5.swift
//  Multithreading
//
//  Created by Tixon Markin on 23.03.2024.
//

import UIKit

class ViewController55: UIViewController {
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            print(await networkService.fetchMessages())
        }
    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

class NetworkService {
    func fetchMessages() async -> [Message] {
        let url = URL(string: "https://hws.dev/user-messages.json")!
        
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let messages = try? JSONDecoder().decode([Message].self, from: data) 
                else {
                    continuation.resume(returning: [])
                    return
                }
                continuation.resume(returning: messages)
            }.resume()
        }
    }
}
