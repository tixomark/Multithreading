//
//  Task3.2Star.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit


/*
 lazy переменные не потокобезопасны
 Тут сразу несколько потоков попытались ее инициализировать, а у нее startNumber, и произошел Data Race из за того, что startNumber попытались сразу из трех потоков изменить.
 Используя NSLock ограничиваем доступ к блоку инициализации someDate только для отдного потока
 
 Тут то мы ограницили количество потоков. Но не ограаниыили соличество потоков, которые могут одновременно образаться к someDate
 */
class ViewController32Star: UIViewController {
    lazy var someDate: Date = {
        lock.lock()
        defer { lock.unlock() }
        print(" \n initialization happens only once!")
        startNumber += 1
        return Date()
    }()
    
    let lock = NSLock()
    var startNumber: Int = 0 {
        willSet(newNumber) {
            print("После иницициализации начнем работать с этим значением: \(newNumber)")
            // какая-то логика
        }
        didSet {
            print("Предыдущее значение: \(oldValue)")
            // какая-то логика
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
        view.backgroundColor = .cyan
        
        DispatchQueue.global().async {
            sleep(1)
            // Имитация какой-то работы
//            self.lock.lock()
            let _ = self.someDate
//            self.lock.unlock()
        }
        
        DispatchQueue.global().async {
            sleep(1)
            // Имитация какой-то работы
//            self.lock.lock()
            let _ = self.someDate
//            self.lock.unlock()
        }
        
        DispatchQueue.global().async {
            sleep(1)
            // Имитация какой-то работы
//            self.lock.lock()
            let _ = self.someDate
//            self.lock.unlock()
        }
    }
}

