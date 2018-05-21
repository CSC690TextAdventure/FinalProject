//
//  InventoryViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 5/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

//InventoryViewController is the view controller that manages our TableView Inventory.
//It holds a reference to the inventory, and should override methods in
//UITableViewController to display the items inside.
//It should also notify the delegate (GameViewController) that an item was tapped.
public class InventoryViewController : UITableViewController {
    
    var inventory : Inventory
    var delegate : InventoryViewControllerDelegate?
    
    //Our initializer, we call our parent constructor and set an InventoryView as our tableView.
    init(_ inventory : Inventory) {
        self.inventory = inventory
        super.init(style: UITableViewStyle.plain)
        self.tableView = InventoryView()
    }
    
    //Ignore this, it's required since we have a custom init function
    required public init?(coder aDecoder: NSCoder) {
        self.inventory = Inventory()
        super.init(coder: aDecoder)
    }
    /*
    public func loadItems(){
    
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadItems()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return inventory.items.count
    }
    
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cellIdentifier = "InventoryTableViewCell"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InventoryTableViewCell")
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InventoryTableViewCell else {
            fatalError("The dequeued cell is not an instance of InventoryCell")
        }
        
        let item = inventory.items[indexPath.row]
        cell.value(forKey: item)
        
        return cell
    }
    */
    
    
}




    
protocol InventoryViewControllerDelegate {
    func inventoryItemWasTapped(_ item : Object)
}
