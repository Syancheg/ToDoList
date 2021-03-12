//
//  Task.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 08.03.2021.
//

import UIKit

protocol Task {
    var id: Int { get set }
    var name: String { get set }
    func addSubtasks(task: Task)
    func removeSubtask(id: Int) -> Bool
    func getSubtasks() -> [Task]
    func getAllSubtasks() -> [Task]
}

class ConcreteTask: Task {
    var name: String = ""
    
    func getAllSubtasks() -> [Task] {
        return [self]
    }
    
    var id: Int = 0

    func addSubtasks(task: Task) {
        
    }
    
    func removeSubtask(id: Int) -> Bool {
        return false
    }
    
    func getSubtasks() -> [Task] {
        return [self]
    }
    
}

final class CompositeTask: Task {
    
    var name: String
    var id: Int
    
    init(name: String) {
        self.name = name
        self.id = TaskRepository.shared.getLastId()
    }
    
    init() {
        self.name = "Main"
        self.id = 0
    }
    
    private var subTasks: [Task] = []
    
    func addSubtasks(task: Task) {
        self.subTasks.append(task)
    }
    
    func removeSubtask(id: Int) -> Bool {
        var isDeleted = false
        for (index, subTask) in subTasks.enumerated() {
            if subTask.id == id {
                subTasks.remove(at: index)
                isDeleted = true
            } else {
                isDeleted = false
            }
        }
        return isDeleted
    }
    
    func getAllSubtasks() -> [Task] {
        var tasks: [Task] = []
        for subTask in subTasks {
            tasks.append(subTask)
            tasks.append(contentsOf: subTask.getSubtasks())
        }
        return tasks
    }
    
    func getSubtasks() -> [Task] {
        return subTasks
    }

}
