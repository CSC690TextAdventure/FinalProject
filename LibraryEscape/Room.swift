//
//  Room.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import Foundation

protocol Room {
    var exits : [String : String] {get set}
    
    var objects : [String] {get set}
    
    var inventory : Inventory {get set}
    
    var thoughtText : String {get set}
    
    func getThoughts () -> String
    
    func changeRoom(to room: Room)
    
}
