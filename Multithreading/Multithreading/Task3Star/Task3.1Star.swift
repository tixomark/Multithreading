//
//  Task3.1Star.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

class ViewController31Star: UIViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
        
        print("R")
        
        let lock = NSLock()
        
        DispatchQueue.global().async {
            
            lock.lock()
            print("A")
            
            
            lock.unlock()
//            lock.lock()
            // Оно умрет прямо тут, так как lock заблокировал доступ к коду дальше. Ну и все, он не пропустит, пока его не разблокируешь
            // Надо либо его совсем убрать(он тут только проблемы создает). Либо разблокировать.
            print("D")
            
            DispatchQueue.main.async {
                print("Map")
            }
        }
        
        print("O")
    }
}
