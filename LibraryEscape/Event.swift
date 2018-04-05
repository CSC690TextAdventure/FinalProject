//
//  Event.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import Foundation

protocol Event {
    
    var eventText : String {get set}
    
    func runEvent (in room : Room, for object : Object )
    
}
