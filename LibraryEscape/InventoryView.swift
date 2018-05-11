//
//  InventoryView.swift
//  LibraryEscape
//
//  Created by Scott Penn on 5/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

//InventoryView is our UITableVIew class. We should just modify how the view looks in this class.
//Most of the work will happen in the controller.
public class InventoryView : UITableView {
    
    init() {
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
