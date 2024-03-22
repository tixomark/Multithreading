//
//  Task3.2.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit

final class ViewController10: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let asyncWorker = AsyncWorker()
        
        asyncWorker.doJobs(postNumbers: 1, 2, 3, 4, 5) { posts in
            print(Thread.current)
            print(posts.map { $0.id })
        }
    }
}

class AsyncWorker {
    let baseURL = "https://jsonplaceholder.typicode.com/todos/"
    
    func doJobs(postNumbers: Int..., completion: @escaping ([Post]) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            var posts = [Post]()
            let group = DispatchGroup()
            
            for i in postNumbers {
                guard let url = URL(string: self.baseURL + i.description) else { return }
                group.enter()
                URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                    guard let data = data else { return }
                    
                    if let post = try? JSONDecoder().decode(Post.self, from: data) {
                        posts.append(post)
                    }
                    group.leave()
                }.resume()
            }
            
            group.notify(queue: .main) {
                completion(posts)
            }
        }
    }
}

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
