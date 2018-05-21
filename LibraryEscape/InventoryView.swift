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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
