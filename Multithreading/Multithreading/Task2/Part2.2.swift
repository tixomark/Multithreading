//
//  Part2.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit

final class ViewController4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        // Меняем приоритеты
        
        // Сначала 1 потом 2
//        thread1.qualityOfService = .userInteractive
//        thread2.qualityOfService = .background
        
        // Сначала 2 потом 1
//        thread1.qualityOfService = .background
//        thread2.qualityOfService = .userInteractive
        
        // Вперемешку
        thread1.qualityOfService = .userInteractive
        thread2.qualityOfService = .userInteractive
        
        thread1.start()
        thread2.start()
    }
}

class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            print("1")
        }
    }
}

class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            print("2")
        }
    }
}
