//
//  Task3.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit

final class ViewController23: UIViewController {
    private var name = "Введите имя"
    private let lockQueue = DispatchQueue(label: "name.lock.queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
    }
    
    /*
    Тут по логике, сначала должно выводиться Введите имя, а потом I love RM. Но из за резвости происходит дата рейс. DispatchQueue.global().async испевает отработать прямо во время принта на 34 строке.
     
     Если поставить DispatchQueue.global().sync, то все будет нормально, так как блок в текущая очередь будет ждать завершения выполнения блока в DispatchQueue.global().sync
     */
    func updateName() {
        DispatchQueue.global().async {
            self.lockQueue.async {
                self.name = "I love RM" // Перезаписываем имя в другом потоке
            }
                print(Thread.current)
                print(self.name)
        }
        
        self.lockQueue.async {
            print(self.name) // Считываем имя из main
        }
    }
}
