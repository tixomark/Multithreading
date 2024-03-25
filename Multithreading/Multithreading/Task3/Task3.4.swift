//
//  Task3.3.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit

final class ViewController34: UIViewController {
    let lock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sharedResource = 0
        
        DispatchQueue.global(qos: .background).async {
            print(Thread.current)
            for _ in 1...100 {
                self.lock.lock()
                sharedResource += 1
                print(sharedResource)
                self.lock.unlock()
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            for _ in 1...100 {
                self.lock.lock()
                sharedResource += 1
                print(sharedResource)
                self.lock.unlock()
            }
        }
    }
}

/*
 Проблема в том, что сразу несколько потоков одновременно пытаются перезаписывать/обратиться к общему ресурсу(sharedResource)
 Такое состояние называется гонкой данных (Data Race)
 */



