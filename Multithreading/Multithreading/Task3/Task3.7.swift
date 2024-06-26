//
//  Task3.7.swift
//  Multithreading
//
//  Created by Tixon Markin on 21.03.2024.
//

import UIKit

final class ViewController37: UIViewController {
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let service = ArrayAdditionService()
           for i in 1...10 {
               service.addElement(i)
           }
           service.cancelAddition()
    }

   // Класс, представляющий сервис операций добавления в массив
   class ArrayAdditionService {
       private var array = [Int]()
       private var pendingWorkItems = [DispatchWorkItem]()

       // Метод для добавления элемента в массив
       func addElement(_ element: Int) {
           // Создаем новую операцию для добавления элемента в массив
           let newWorkItem = DispatchWorkItem { [weak self] in
               self?.array.append(element)
               print("Элемент \(element) успешно добавлен в массив.")
           }

           // Сохраняем новую операцию
           pendingWorkItems.append(newWorkItem)

           // Даем пользователю время для отмены операции
           DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
               // Логика тут eсли операция не была отменена, выполняем ее
               // ...
               guard !newWorkItem.isCancelled else { return }
               newWorkItem.perform()
           }
       }

       // Метод для отмены операции добавления элемента в массив
       func cancelAddition() {
           guard let lastWorkItem = pendingWorkItems.last else {
               print("Нет операций для отмены.")
               return
           }

           // Тут отменяем последнюю операцию
           // ...
           lastWorkItem.cancel()
       }
   }
}
