//
//  Task2.6.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit

final class ViewController7: UIViewController {
    private var _name = "Введите имя"
    private var lock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
    }
    
    
    /*
     Проблема в том, что один поток пытается записать переменную пока другой ее читает.
     */
    func updateName() {
        DispatchQueue.global().async {
            
            self.lock.lock()
            // Тут в задании видимо забыли строку
            self._name = "I love RM"
            self.lock.unlock()
            
            print(self._name) // Считываем имя из global
            print(Thread.current)
        }
        
        self.lock.lock()
        print(self._name) // Считываем имя из main
        self.lock.unlock()
    }
}
