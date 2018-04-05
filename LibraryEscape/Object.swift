//
//  Object.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import Foundation

protocol Object : class {
    
    var LookAtEvent : Event? {get set}
    
    var PickUpEvent : Event? {get set}
    
    var InteractEvent : Event? {get set}
    
    var UseEvent : Event? {get set}
    
    var inventoryText : String {get}
    
}


