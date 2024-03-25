//
//  Task5.2.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

final class ViewController52: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(1)
        
        Task { @MainActor in 
            print(2)
        }
        
        print(3)
    }
}

/*
 Tack c @MainActor гарантированно будет запущена на главном потоке.
 */
