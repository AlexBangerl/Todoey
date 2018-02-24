//
//  ViewController.swift
//  Todoey
//
//  Created by Alexander Bangerl on 2/23/18.
//  Copyright © 2018 Alexander Bangerl. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    //MARK - TableView Data Source Methods
    ////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create a reusable cell with the prototype cell identifier and change IndexPath to indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //set the lable of the cell to the data you want to display
        cell.textLabel!.text = itemArray[indexPath.row]
        
        return cell
    }
    
    
    //MARK - TableView Delegate Method
    ////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //add a checkmark to the cell that was selected if it doesnt have one yet and remove it when it already has one
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //when select a cell is usually stays grey until select other cell but we want it to just light up quickly and thats what this method does
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    ////////////////////////////////////////////////////
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //make an alert windo pop up with a message
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //create a action button in the alert
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add icon button in the UIAlert
            
            //append the new item to the item array
            self.itemArray.append(textField.text!)
            
            //reload the data to update the table and add the new added item
            self.tableView.reloadData()
            
        }
        
        //This method gets triggered when the add icon is pressed -> adds a textfield to alert
        alert.addTextField { (alertTextField) in
            //add a placeholder
            alertTextField.placeholder = "Create new item"
            //assign local variable to var with bigger scope
            textField = alertTextField
        }
        
        //add the action button above to the alert
        alert.addAction(action)
        
        //display the alert
        present(alert, animated: true, completion: nil)
        
    }
    
}

