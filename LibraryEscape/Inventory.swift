//
//  Inventory.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

class Inventory {
    
    var items = [Object]()
    
    func addItem (_ item : Object) {
        items.append(item)
    }
    
    func removeItem (_ name : String) {
        items = items.filter { item in
            item.objectName != name
        }
    }
    
}
