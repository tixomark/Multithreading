//
//  Task5.4.swift
//  Multithreading
//
//  Created by Tixon Markin on 23.03.2024.
//

import UIKit

class ViewController54: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            async let result = randomD6()
            print(await result)
        }
    }
    
    func randomD6() async -> Int {
        Int.random(in: 1...6)
    }
    
}
