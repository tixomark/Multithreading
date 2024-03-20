//
//  Part1.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit


class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        print(infinityThread.isFinished)
        
        infinityThread.start()
        
        print(infinityThread.isExecuting)

        // Подождем некоторое время, а затем отменяем выполнение потока
        sleep(2)
        
        // Отменяем тут
        infinityThread.cancel()
        
        print(infinityThread.isExecuting)
        print(infinityThread.isFinished)
        print(infinityThread.isCancelled)
        
        sleep(2)
        print(infinityThread.isFinished)
    }
}


class InfinityLoop: Thread {
    var counter = 0
    
    override func main() {
        while counter < 30 && !isCancelled {
            counter += 1
            print(counter)
            InfinityLoop.sleep(forTimeInterval: 1)
        }
    }
}
