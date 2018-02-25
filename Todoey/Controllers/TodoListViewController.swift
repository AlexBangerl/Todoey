//
//  ViewController.swift
//  Todoey
//
//  Created by Alexander Bangerl on 2/23/18.
//  Copyright © 2018 Alexander Bangerl. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //needed to persist data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.titel = "Find Mike"
        itemArray.append(newItem)
        
        //load the array from the users phone -> in this case we take data from the key ToDoListArray and take it as an array of Strings
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }

    
    //MARK - TableView Data Source Methods
    ////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create a reusable cell with the prototype cell identifier and change IndexPath to indexPath
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //set the lable of the cell to the data you want to display
        cell.textLabel!.text = item.titel
        
        //add a checkmark to the cell that was selected if it doesnt have one yet and remove it when it already has one
        //structure used here is turnery operator: value = condition valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK - TableView Delegate Method
    ////////////////////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //when user tabs on the item it will change the done value of the object to opposite
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //forces the TableView to call the data source methods again
        tableView.reloadData()
        
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
            
            //set what the user typed in to a new item object
            let newItem = Item()
            newItem.titel = textField.text!
            
            //append the new item to the item array
            self.itemArray.append(newItem)
            
            //save the item array to the user defaults
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
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

