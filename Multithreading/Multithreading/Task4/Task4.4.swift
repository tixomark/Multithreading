//
//  Task4.4.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit


final class ViewController17: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Использование
        let threadSafeArray = ThreadSafeArray()
        let operationQueue = OperationQueue()
        
        // Второй вариант решения - установить максимальное количество одновременно выполняемых операций для очереди
        operationQueue.maxConcurrentOperationCount = 1
        
        let firstOperation = FirstOperation(threadSafeArray: threadSafeArray)
        let secondOperation = SecondOperation(threadSafeArray: threadSafeArray)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        
        // Дождитесь завершения операций перед выводом содержимого массива
        operationQueue.waitUntilAllOperationsAreFinished()
        
        print(threadSafeArray.getAll())
    }
}

// Объявляем класс для для синхронизации потоков
class ThreadSafeArray {
    private var array: [String] = []
    private let lock = NSLock()
    
    /*
     Проблем называется Data Race. Когде сразу минимум 2 потока одновременно пытаются обратиться к общему ресурсу, и хотыбя один из них пытается его перезаписать
     Первфй вариант - дать одновременный доступ в ресурсу только одному потоку
     */
    
    func append(_ item: String) {
//        lock.lock()
        array.append(item)
//        lock.unlock()
    }
    
    func getAll() -> [String] {
//        lock.lock()
//        defer { lock.unlock() }
        return array
    }
}

// Определяем первую операцию для добавления строки в массив
class FirstOperation: Operation {
    let threadSafeArray: ThreadSafeArray
    
    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Первая операция")
    }
}

// Определяем вторую операцию для добавления строки в массив
class SecondOperation: Operation {
    // Создаем по образу первой операции
    let threadSafeArray: ThreadSafeArray
    
    init(threadSafeArray: ThreadSafeArray) {
        self.threadSafeArray = threadSafeArray
    }
    
    override func main() {
        if isCancelled { return }
        threadSafeArray.append("Вторая операция")
    }
}
