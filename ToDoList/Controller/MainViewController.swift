//
//  MainViewController.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 08.03.2021.
//

import UIKit

class MainViewController: UIViewController, MainViewDelegate {

    lazy var contentView = self.view as! MainView
    private var mainCompositeTasks: Task = CompositeTask(name: "Главная")
    private var viewController: MainViewController {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storybord.instantiateViewController(identifier: "MainViewController") as! MainViewController
        return  viewController
    }

    @IBAction func addTask(_ sender: UIBarButtonItem) {
        showTaskAlert()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
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
        mainCompositeTasks.addSubtasks(task: task)
        contentView.tasks = mainCompositeTasks.getTasks()
        contentView.tableView.reloadData()
    }
    
    func changeTask(index: Int) {
        viewController.mainCompositeTasks = mainCompositeTasks.getTask(index: index)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
