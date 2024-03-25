//
//  Task2.4.swift
//  Multithreading
//
//  Created by Tixon Markin on 20.03.2024.
//

import UIKit

final class ViewController24: UIViewController {
    // B выведется в самом конце, так как эта задача была добавлена на серийную очередь, в то время как на ней испольнялся viewDidLoad. В будет ждать, пока главная очередь обвободится.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("A")
        
        DispatchQueue.main.async {
            print("B")
        }
        
        print("C")
    }
}
