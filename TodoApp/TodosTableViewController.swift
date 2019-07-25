//
//  TodosTableViewController.swift
//  TodoApp
//
//  Created by Ben Scheirman on 7/25/19.
//  Copyright © 2019 NSScreencast. All rights reserved.
//

import UIKit
import CoreData

class TodosTableViewController: UITableViewController {

    var context: NSManagedObjectContext? {
        didSet {
            loadTodos()
        }
    }

    var todos: [String] = []

    private weak var newItemTextField: UITextField!
    private let newItemCellIndexPath = IndexPath(row: 0, section: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    private func loadTodos() {
        guard let context = context else { fatalError() }
        let fetchRequest: NSFetchRequest<TodoItem> = NSFetchRequest(entityName: "TodoItem")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "sortOrder", ascending: true)]
        context.perform {
            let todoItems = try! fetchRequest.execute()
            self.todos = todoItems.map { $0.text }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return todos.count
        } else {
            return 1
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
            cell.label.text = todos[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newItemCell", for: indexPath) as! NewItemCell
            newItemTextField = cell.textField
            newItemTextField.delegate = self
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != newItemCellIndexPath.section
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        let todo = todos.remove(at: fromIndexPath.row)
        todos.insert(todo, at: to.row)
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapAdd(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.scrollToRow(at: self.newItemCellIndexPath, at: .middle, animated: false)
        }) { _ in
            self.newItemTextField.becomeFirstResponder()
        }
    }

}

extension TodosTableViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end editing")
    }
}
