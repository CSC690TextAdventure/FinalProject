//
//  Object.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

protocol Object : class {
    
    var objectName : String {get set}
    
    var LookAtEvent : Event? {get set}
    
    var PickUpEvent : Event? {get set}
    
    var InteractEvent : Event? {get set}
    
    var UseEvent : Event? {get set}
    
    var inventoryText : String {get}
    
}

var ObjectDictionary : [String : Object] = [
    "Study Room B Key" : StudyRoomBKey()
]

class StudyRoomBKey: Object {
    
    var objectName = "Shiny Object"
    
    var LookAtEvent: Event? = StudyRoomBKeyLookAt()
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = "A key I found in the Study Room I woke up in. Why was it there?"
}


