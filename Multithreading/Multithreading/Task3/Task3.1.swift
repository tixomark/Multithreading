//
//  Task3.1.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit
 
//MARK: - Решение через Semaphor

final class ViewController8: UIViewController {
    
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phrasesService = PhrasesService()
        
        for i in 0..<10 {
            DispatchQueue.global(qos: .background).async {
                self.semaphore.wait()
                phrasesService.addPhrase("Phrase \(i)")
                self.semaphore.signal()
                
            }
        }
        
        // Даем потокам время на завершение работы
        Thread.sleep(forTimeInterval: 1)
        
        self.semaphore.wait()
        print(phrasesService.phrases)
        self.semaphore.signal()
    }
    
    class PhrasesService {
        var phrases: [String] = []
        
        func addPhrase(_ phrase: String) {
            phrases.append(phrase)
        }
    }
}


//MARK: - Решение через Actor

final class ViewController9: UIViewController {
    let lock = NSLock()
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let phrasesService = PhrasesService()
        
        for i in 0..<10 {
            DispatchQueue.global().async {
                self.lock.lock()
                phrasesService.addPhrase("Phrase \(i)")
                self.lock.unlock()
            }
        }
        
        // Даем потокам время на завершение работы
        Thread.sleep(forTimeInterval: 1)
        
        Task {
            await print(phrasesService.phrases)
        }
    }
    
}

actor PhrasesService {
    var phrases: [String] = []
    
    func addPhrase(_ phrase: String) {
        phrases.append(phrase)
    }
}
