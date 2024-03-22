import UIKit

var greeting = "Hello, playground"


let serialQueue = DispatchQueue(label: "com.example.myQueue")

// 1 блок
serialQueue.async {
    // 2 блок
    serialQueue.sync {
        print("This will never be printed.")
    }
}

/*
 Наша serial очередь пытается запустить 2 блок синхронно относительно самой себя. Но она сечас выполняет 1 блок, а он пытается запустить 2 блок. Так как очередь serial, то
 блок 2 не запустится пока не завершится блок 1. А блок 1 не завершится, пока не запустится блок 2.
 
 Называется deadlock ( от слова дед)) )
 */
