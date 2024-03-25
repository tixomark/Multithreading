//
//  Task5.7.swift
//  Multithreading
//
//  Created by Tixon Markin on 23.03.2024.
//

import UIKit

class ViewController57: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await getAverageTemperature()
        }
    }
    
    func getAverageTemperature() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            
            try Task.checkCancellation()
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if Task.isCancelled {
                throw CancellationError()
            }
            
            let readings = try JSONDecoder().decode([Double].self, from: data)
            let sum = readings.reduce(0, +)
            return sum / Double(readings.count)
        }
        
        // Тут отмените задачу
        fetchTask.cancel()
        
        do {
            let result = try await fetchTask.value
            print("Average temperature: \(result)")
        } catch {
            print("Failed to get data.")
        }
    }
}
