//
//  ViewController.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit

final class ViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("1, Current thread: \(currentThread)")
            }
        }
        
        for _ in (0..<10) {
            let currentThread = Thread.current
            print("2, Current thread: \(currentThread)")
        }
        
        /*
         Так как на одном потоке задачи выполняются строго друг за другом, мы получали последовательные принты.
         Вывод изменился так как мы перенесли часть задач на другой поток. И теперь они выполняются параллельно.
         */
    }
}
