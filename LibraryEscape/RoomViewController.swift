//
//  RoomViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 5/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    var room : Room
    var delegate : RoomViewControllerDelegate?
    
    init(_ room : Room) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
        self.view = RoomView(room)
        (self.view as! RoomView).delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.room = StudyRoomB()
        super.init(coder: aDecoder)
    }
}

extension RoomViewController : RoomViewDelegate {
    func didTapRoomName(_ room: Room) {
        delegate?.didTapRoomName(room)
    }
    
    func moveToRoom(_ room: Room) {
        delegate?.moveToRoom(room)
    }
    
    
}

protocol RoomViewControllerDelegate : RoomViewDelegate {
    
}
