//
//  Task5.3.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

class ViewController53: UIViewController {
    

    override func viewDidLoad() {
            super.viewDidLoad()
        
        print("Task 1 is finished")
       
        Task.detached {
            for i in 0..<50 {
                print(i)
            }
            print("Task 2 is finished")
            print(Thread.current)
        }
        
        print("Task 3 is finished")
    }
}

/*
 Разничи нет. Используя очередь мы запускали задачу асинхронно на другом потоке. Используя Task.detached мы запускаем задачу на другом потоке. + Таски по умолчанию запускаются асинхронно.
 */
