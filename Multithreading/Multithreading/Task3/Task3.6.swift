//
//  Task3.6.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit

class ViewController13: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        DispatchQueue.global().async {
            self.thread1()
        }

        DispatchQueue.global().async {
            self.thread2()
        }
    }
    
  /*
   Тут дедлок. Оба потока пытаются опратиться к общим ресурсам и блокируют друг друга. Рещить проблему можно просто убрав блокировку(поменяв очередность обращения к ресурсам так, чтобы оба ресурса могли быть одновременно захвачены только одним потоком)
   */

    let resourceASemaphore = DispatchSemaphore(value: 1)
    let resourceBSemaphore = DispatchSemaphore(value: 1)

    func thread1() {
        print("Поток 1 пытается захватить Ресурс A")
        resourceASemaphore.wait() // Захват Ресурса A
        
        print("Поток 1 захватил Ресурс A и пытается захватить Ресурс B")
        Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock
        
        resourceBSemaphore.wait() // Попытка захвата Ресурса B, который уже занят Потоком 2
        print("Поток 1 захватил Ресурс B")
        
        resourceBSemaphore.signal()
        resourceASemaphore.signal()
    }

    func thread2() {
        resourceASemaphore.wait() // Попытка захвата Ресурса A, который уже занят Потоком 1
        print("Поток 2 пытается захватить Ресурс A")
        
        print("Поток 2 захватил Ресурс А и пытается захватить Ресурс В")
        Thread.sleep(forTimeInterval: 1) // Имитация работы для демонстрации livelock
        
        print("Поток 2 захватил Ресурс B")
        resourceBSemaphore.wait() // Захват Ресурса B
        
        resourceASemaphore.signal()
        resourceBSemaphore.signal()
    }
}
