//
//  Room.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

protocol Room : class {
    var roomName : String {get}
    
    var exits : [Direction : String] {get set}
    
    var objects : [String] {get set}
    
    var inventory : Inventory? {get set}
    
    var thoughtText : String {get set}
    
    var roomDescription : String {get set}

    func removeObject(_ name : String)
}

extension Room {
    func removeObject (_ name : String) {
        objects = objects.filter {$0 != name}
    }
}

enum Direction {
    case North, South, East, West
}

var RoomDictionary : [String : Room] = [
    "Study Commons Room B" : StudyRoomB(),
    "Study Commons West" : StudyCommonsWest(),
    "Study Commons Room M" : StudyRoomM(),
    "Study Commons East" : StudyCommonsEast(),
    "Staff Storage Room" : StaffRoom(),
    "Elevators Ground Floor" : ElevatorsGroundFloor()
]

class StudyRoomB : Room {
    var roomName: String = "Study Commons Room B"
    
    var exits: [Direction : String] = [:]
    
    var objects: [String] = ["Study Room B Key", "Study Room Exit"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "I must have fallen asleep. I'm sure I can just walk out of here, right?"
    
    var roomDescription: String = "It's the study room I fell asleep in. Everything is just how I left it, only the door is locked. Great."
}

class StudyCommonsWest : Room {
    var roomName: String = "Study Commons West"
    
    var exits: [Direction : String] = [.South : "Study Commons Room B",
                                       .East : "Study Commons East"]
    
    var objects: [String] = ["Computers", "Study Room Doors"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "I can make my way to the exit from here. A bit more and I'm home free."
    
    var roomDescription: String = "Only a few of the lights remain on, but it's enough to make out the rows of computers lining the Study Commons."
}

class StudyCommonsEast : Room {
    var roomName: String = "Study Commons East"
    
    var exits: [Direction : String] = [.West : "Study Commons West"]
    
    var objects: [String] = ["Study Commons Exit"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "I can see the doors to the hallway leading outside from here. I should make my way over there."
    
    var roomDescription: String = "The entrance to the Study Commons computer lab. I've spent many nights working on assignments here."
}

class StudyRoomM : Room {
    var roomName: String = "Study Commons Room M"
    
    var exits: [Direction : String] = [.South : "Study Commons West"]
    
    var objects: [String] = ["Television", "Red Folder"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "I need to look around for anything that might unlock the exits."
    
    var roomDescription: String = "Nearly identical to the study room I woke up in. It was the only room left unlocked. Odd, the TV is still on."
}

class StaffRoom : Room {
    var roomName: String = "Staff Storage Room"
    
    var exits: [Direction : String] = [.West : "Study Commons East"]
    
    var objects: [String] = ["Electronic Equipment", "Supplies", "Staff Paperwork"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "If anyone would have a key to the library, it would be the staff. I've never seen anyone here except students, but it's worth a look."
    
    var roomDescription: String = "A storage space for printing supplies and electronic equipment used in the library. It's messy."
}

class ElevatorsGroundFloor : Room {
    var roomName: String = "Ground Floor Elevators"
    
    var exits: [Direction : String] = [.North : "Study Commons East"]
    
    var objects: [String] = ["Restroom Entrances", "Elevator Call Button"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "Even if the Study Commons exit is locked, I can just take an elevator to the first floor entrance."
    
    var roomDescription: String = "The elevators and restrooms for the Ground Floor. The library has six floors."
}




