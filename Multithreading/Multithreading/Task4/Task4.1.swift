//
//  Task4.1.swift
//  Multithreading
//
//  Created by Tixon Markin on 22.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     
     Ошибка воникает из за того, для классо надо реализовавыть sendable в ручную. А enum считается sendable если, в том числе, ассоциативные значения его кейсов тоже sendable.
     
     Тут два варианта решения,
     1 заменить class на struct. Структуры по умолчению sendable, если содержат тольк свойства типа sendable
     
     2  Дописать final перед Post и подписать его под sendable.
     */
    
    final class Post: Sendable {}
    // или
//    struct Post {}
    
    enum State1: Sendable {
        case loading
        case data(String)
    }
    
    enum State2: Sendable {
        case loading
        case data(Post)
        // Out: Associated value 'data' of 'Sendable'-conforming enum 'State2' has non-sendable type 'ViewController.Post'
    }
    
}
