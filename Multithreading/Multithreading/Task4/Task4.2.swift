//
//  Task4.2.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

protocol RMOperationProtocol {
    // Приоритеты
    var priority: DispatchQoS.QoSClass { get }
    // Выполняемый блок
    var completionBlock: (() -> Void)? { get }
    // Завершена ли операция
    var isFinished: Bool { get }
    // Запущена ли операция
    var isExecuting: Bool { get }
    // Метод для запуска операции
    func start()
}

class RMOperation: RMOperationProtocol {
    var priority: DispatchQoS.QoSClass = .unspecified
    
    var completionBlock: (() -> Void)? = { }
    
    var isFinished: Bool = false
    
    var isExecuting: Bool = false
    
    func start() {
        if !isFinished {
            isExecuting = true
            DispatchQueue.global(qos: priority).async {
                print("Doing heavy work")
                self.completionBlock?()
                print("Heavy work done")
                self.isExecuting = false
            }
        } else {
            print("Ops operation has finished")
        }
    }
    /// В методе start. реализуйте все через глобальную паралельную очередь с приоритетами.
 
}

final class ViewController15: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let operationFirst = RMOperation()
        let operationSecond = RMOperation()
        
        
        operationFirst.priority = .userInitiated
        operationFirst.completionBlock = {
            
            for _ in 0..<50 {
                print(2)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        
        operationFirst.start()
        
        operationSecond.priority = .background
        operationSecond.completionBlock = {
            
            for _ in 0..<50 {
                print(1)
            }
            print(Thread.current)
            print("Операция полностью завершена!")
        }
        operationSecond.start()
        
    }
}

