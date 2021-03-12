//
//  MainViewController.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 08.03.2021.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate {

    lazy var contentView = self.view as! MainView
    var mainTask: Task?

    @IBAction func addTask(_ sender: UIBarButtonItem) {
        showTaskAlert()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        loadTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.tableView.reloadData()
    }
    
    private func loadTasks(){
        if mainTask == nil {
            mainTask = TaskRepository.shared.getMainTask()
        }

        if let task = mainTask {
            contentView.tasks = task.getSubtasks()
        }
    }
    
    private func showTaskAlert(){
        let alert = UIAlertController(title: "Ввод задачи", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Введите название задачи"
        })
        alert.addAction(UIAlertAction(title: "Сохранить",
                                      style: .default,
                                      handler: { action in
                                        if let task = alert.textFields?.first?.text {
                                            self.appendTask(taskName: task)
                                        }
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func appendTask(taskName: String){
        let task = CompositeTask(name: taskName)
        if let mainTask = self.mainTask {
            TaskRepository.shared.addTask(newTask: task, mainTask: mainTask)
            contentView.tasks.append(task)
        }
    }
    
    func changeTask(task: Task) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybord.instantiateViewController(identifier: "MainViewController") as! MainViewController
        viewController.mainTask = task
        viewController.title = task.name
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
