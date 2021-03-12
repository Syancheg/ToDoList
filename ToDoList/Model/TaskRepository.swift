//
//  TaskRepository.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 11.03.2021.
//

import UIKit

class TaskRepository {
    static let shared = TaskRepository()
    private lazy var lastId: Int = 0
    private lazy var task: Task = {
        return CompositeTask()
    }()

    private init() {}

    func addTask(newTask: Task, mainTask: Task){
        if mainTask.id == task.id {
            task.addSubtasks(task: newTask)
            lastId += 1
        } else {
            for subTask in task.getAllSubtasks() {
                if subTask.id == mainTask.id {
                    subTask.addSubtasks(task: newTask)
                    lastId += 1
                    break
                }
            }
        }
    }

    func getMainTask() -> Task {
       return task
    }

    func getLastId() -> Int {
        return lastId
    }

}
