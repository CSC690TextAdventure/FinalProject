//
//  Room.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

protocol Room {
    var roomName : String {get}
    
    var exits : [Direction : String] {get set}
    
    var objects : [String] {get set}
    
    var inventory : Inventory? {get}
    
    var thoughtText : String {get set}
    
}

enum Direction {
    case North, South, East, West
}

struct StudyRoomB : Room {
    var roomName: String = "Study Commons Room B"
    
    var exits: [Direction : String] = [.North : "StudyCommonsWest"]
    
    var objects: [String] = ["StudyRoomBKey"]
    
    var inventory: Inventory?
    
    var thoughtText: String = ""
}


