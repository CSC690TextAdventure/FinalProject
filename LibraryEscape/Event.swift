//
//  Event.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

protocol Event {
    
    var eventText : String {get set}
    
    var eventCount : Int {get set}
    
    mutating func runEvent (in room : Room, for object : Object )
    
}

class StudyRoomBKeyLookAt : Event {
    var eventText = "There's something shiny under one of the chairs. I should take a closer look."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        switch eventCount {
        case 0:
            eventText = "It looks like a key. I have no idea what it's for or how it got here."
        case 1:
            object.objectName = "Study Room Key"
            object.PickUpEvent = StudyRoomBKeyPickUp()
            eventText = "Yep, it's a key. It looks like it might fit into the door handle lock."
        default:
            eventText = "A key. Keys are used to open doors. There is a door in the room."
        }
        eventCount += 1
    }
}

class StudyRoomBKeyPickUp : Event {
    var eventText = "I pick up the key and examine it closely. I should try it on the door."
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        room.removeObject("Study Room B Key")
        room.inventory?.addItem("Study Room B Key")
        object.UseEvent = StudyRoomBKeyUse()
    }
}

class StudyRoomBKeyUse : Event {
    var eventText = "I fumble with the key for a moment but the door unlocks after a few attempts. Finally!"
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        room.inventory?.removeItem("Study Room B Key")
        room.exits[.North] = "Study Commons West"
        room.roomDescription = "It's the study room I fell asleep in. I don't know why I came back here."
        room.thoughtText = "The door's unlocked now. I don't see anything else that could help me."
    }
}
