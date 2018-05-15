//
//  Room.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

var RoomDictionary : [String : Room] = [
    "Study Commons Room B" : StudyRoomB()
]

protocol Room {
    var roomName : String {get}
    
    var exits : [Direction : String] {get set}
    
    var objects : [String] {get set}
    
    var inventory : Inventory? {get}
    
    var thoughtText : String {get set}
    
    var roomDescription : String {get}
    
}

enum Direction {
    case North, South, East, West
}


struct StudyRoomB : Room {
    var roomName: String = "Study Commons Room B"
    
    var exits: [Direction : String] = [.North : "Study Commons West"]
    
    var objects: [String] = ["Study Room B Key"]
    
    var inventory: Inventory?
    
    var thoughtText: String = "I must have fallen asleep. I'm sure I can just walk out of here, right?"
    
    var roomDescription: String = "It's the study room I fell asleep in. Everything is just how I left it, except for the lock on the door."
}


