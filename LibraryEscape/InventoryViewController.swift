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
    
}

protocol InventoryViewControllerDelegate {
    func inventoryItemWasTapped(_ item : Object)
}
