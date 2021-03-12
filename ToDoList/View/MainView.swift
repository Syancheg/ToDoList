//
//  MainView.swift
//  ToDoList
//
//  Created by Константин Кузнецов on 08.03.2021.
//

import UIKit

protocol MainViewDelegate {
    func changeTask(task: Task)
}

class MainView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tasks: [Task] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var delegate: MainViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        cell.taskNameLabel.text = tasks[indexPath.row].name + " — \(tasks[indexPath.row].getSubtasks().count) подзадач"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        delegate?.changeTask(task: task)
    }

}
