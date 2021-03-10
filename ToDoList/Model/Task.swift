//
//  Task.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 08.03.2021.
//

import UIKit

protocol Task {
    var name: String { get set }
    func description() -> String
    func getTasks() -> [Task]
    func getTask(index: Int) -> Task
    func addSubtasks(task: Task)
    func contentCount() -> Int
    func convertTask(task: Task)
}

class ConcreteTask: Task {

    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func addSubtasks(task: Task) {
        
    }
    
    func convertTask(task: Task) {
        
    }
    
    func getTask(index: Int) -> Task {
        return self
    }
    
    func getTasks() -> [Task] {
        return []
    }
    
    func contentCount() -> Int {
        return 0
    }
    
    func description() -> String {
        return "\(name) — 0 подзадач"
    }
    
}

class CompositeTask: Task {
    
    var name: String
    private var subtasks = [Task]()
    
    init(name: String) {
        self.name = name
    }
    
    func addSubtasks(task: Task){
        subtasks.append(task)
    }
    
    func getTasks() -> [Task] {
        return subtasks
    }
    
    func contentCount() -> Int {
        return subtasks.count
    }
    
    func getTask(index: Int) -> Task {
        let task = index < subtasks.count ? subtasks[index] : subtasks[subtasks.count - 1]
        return task
    }
    
    func convertTask(task: Task) {
        if task is CompositeTask {
            for i in 0..<subtasks.count {
                if subtasks[i].name == task.name,
                   subtasks[i] is ConcreteTask {
                    subtasks[i] = task
                }
            }
        }
    }
    
    func description() -> String {
        return "\(name) — \(subtasks.count) подзадач"
    }
 
}
