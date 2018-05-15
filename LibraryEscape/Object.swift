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
    "Cellphone" : Cellphone(),
    "Study Room B Key" : StudyRoomBKey(),
    "Study Room Exit" : StudyRoomBDoor(),
    "Computers" : Computers(),
    "Study Room Doors" : StudyRoomDoors(),
    "Study Commons Exit" : StudyCommonsExit(),
    "Storage Room Door" : StaffRoomDoor(),
    "Help Desk" : HelpDesk()
    
]

class Cellphone: Object {
    
    var objectName = "Cellphone"
    
    var LookAtEvent: Event? = nil
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = CellphoneUse()
    
    let inventoryText = "My cellphone. It's out of juice. Could serve as a mirror in a pinch."
}

class StudyRoomBKey: Object {
    
    var objectName = "Shiny Object"
    
    var LookAtEvent: Event? = StudyRoomBKeyLookAt()
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = "A key I found in the Study Room I woke up in. Why was it there?"
}

class StudyRoomBDoor: Object {
    
    var objectName = "Study Room Exit"
    
    var LookAtEvent: Event? = StudyRoomBDoorLookAt()
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = StudyRoomBDoorInteract()
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}

class Computers: Object {
    
    var objectName = "Computers"
    
    var LookAtEvent: Event? = ComputersLookAt()
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}

class StudyRoomDoors: Object {
    
    var objectName = "Study Room Doors"
    
    var LookAtEvent: Event? = nil
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}

class StudyCommonsExit: Object {
    
    var objectName = "Study Commons Exit"
    
    var LookAtEvent: Event? = StudyCommonsExitLookAt()
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = StudyCommonsExitInteract()
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}

class StaffRoomDoor: Object {
    
    var objectName = "Storage Room Door"
    
    var LookAtEvent: Event? = nil
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}

class HelpDesk: Object {
    
    var objectName = "Help Desk"
    
    var LookAtEvent: Event? = nil
    var PickUpEvent: Event? = nil
    var InteractEvent: Event? = nil
    var UseEvent: Event? = nil
    
    let inventoryText = ""
}


