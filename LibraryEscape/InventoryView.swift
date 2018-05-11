//
//  InventoryView.swift
//  LibraryEscape
//
//  Created by Scott Penn on 5/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

public class InventoryView : UITableView {
    let inventory : Inventory
    
    init(_ inventory : Inventory) {
        self.inventory = inventory
        super.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        setHeight(to: UIScreen.main.bounds.height / 2)
        backgroundColor = UIColor.orange
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
