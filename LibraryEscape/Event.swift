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

struct StudyRoomBKeyLookEvent : Event {
    var eventText = "There's something shiny under one of the chairs. I should take a closer look."
    
    var eventCount = 0
    mutating func runEvent(in room: Room, for object: Object) {
        switch eventCount {
        case 0:
            eventText = "It looks like a key. I have no idea what it's for or how it got here."
            object.objectName = "Study Room Key"
        case 1:
            eventText = "Yep, it's a key. It looks like it might fit into the door handle lock."
        default:
            eventText = "A key. Keys are used to open doors. There is a door in the room."
        }
        eventCount += 1
    }
}
