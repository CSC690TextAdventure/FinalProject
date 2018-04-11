//
//  Room.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import Foundation

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
    let roomName = "Ground Floor: Group Study Room B"
    
    var exits = [Direction.North : "Ground Floor: Study Commons West"]
    
    var objects = ["StudyRoomCDoor", "StudyRoomCKey"]
    
    var inventory: Inventory?
    
    var thoughtText = "I was studying here last night, I must have fallen asleep. Where is everyone?"
}
