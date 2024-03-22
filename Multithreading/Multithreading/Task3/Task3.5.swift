//
//  Task3.5.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit

class ViewController12: UIViewController {
    
    let semaphore = DispatchSemaphore(value: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people1 = Human(name: "People 1")
        let people2 = Human(name: "People 2")
        
        let thread1 = Thread {
            people1.walkPast(with: people2)
        }

        thread1.start()

        let thread2 = Thread {
            people2.walkPast(with: people1)
        }

        thread2.start()
    }
}

/*
 Данная прослема называется Live Lock. Когда потоки бесконечно перебрасываются работой и ни один из них не может ее сделать.
 */

class Human {
    var name: String
    var isDifferentDirections: Bool {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _isDifferentDirections
        }
        
        set {
            lock.lock()
            _isDifferentDirections = newValue
            lock.unlock()
        }
    }
    private let lock = NSLock()
    private var _isDifferentDirections = false
    
    init(name: String) {
        self.name = name
    }
    
    func walkPast(with people: Human) {
        while (!people.isDifferentDirections) {
            print("\(name) не может обойти \(people.name)")
            if Int.random(in: 0...6) < 5 {
                isDifferentDirections = true
            }
            sleep(1)
        }
        
        print("\(name) смог пройти прямо")
        isDifferentDirections = true
    }
}

