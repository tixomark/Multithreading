//
//  Task5.1.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

final class ViewController51: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
        print(1)
        
        Task {
            print(2)
        }
        
        print(3)
    }
}

/*
 Ну печатается как печатается, так как мы закинули 2 на main очередь асинхронно(там сейчас выполняется viewDidLoad, закинули 2 после него). Так как main - серийная, то 2 выполнится только после текущего блока.
 */

/*
 При замене на Task все то же самое. Так как Task запускается асинхронно.
 */
