//
//  Task5.8.swift
//  Multithreading
//
//  Created by Tixon Markin on 23.03.2024.
//

import UIKit

final class ViewController58: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await printMessage()
        }
    }
    
    func printMessage() async {
        let string = await withTaskGroup(of: String.self) { group in
            // тут добавляем строки в группу
            for word in ["Hello", "My", "Road", "Map", "Group"] {
                group.addTask { word }
            }
            
            var collected = [String]()
            for await value in group {
                collected.append(value)
            }
            
            return collected.joined(separator: " ")
        }
        
        print(string)
    }
}
