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
    var roomView : RoomView?
    
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        roomView = RoomView(room)
        
        let northTap = UITapGestureRecognizer(target: self, action: #selector(RoomViewController.northButtonTapped))
        let westTap = UITapGestureRecognizer(target: self, action: #selector(RoomViewController.westButtonTapped))
        let southTap = UITapGestureRecognizer(target: self, action: #selector(RoomViewController.southButtonTapped))
        let eastTap = UITapGestureRecognizer(target: self, action: #selector(RoomViewController.eastButtonTapped))
        
        roomView?.options.forEach {option in
            option.isUserInteractionEnabled = true
        }
        
        roomView?.options[0].addGestureRecognizer(northTap)
        roomView?.options[1].addGestureRecognizer(westTap)
        roomView?.options[2].addGestureRecognizer(southTap)
        roomView?.options[3].addGestureRecognizer(eastTap)
        
        
        self.view = roomView!
    }
    
    @objc func northButtonTapped () {
        let text = roomView?.options[0].text
        if text == "Look At" {
            delegate?.optionWasTapped("North")
        } else {
            //??
        }
    }
    
    @objc func westButtonTapped () {
        let text = roomView?.options[1].text
        if text == "Look At" {
            delegate?.optionWasTapped("West")
        } else {
            //??
        }
    }
    
    @objc func southButtonTapped () {
        let text = roomView?.options[2].text
        if text == "Look At" {
            delegate?.optionWasTapped("South")
        } else {
            //??
        }
    }
    
    @objc func eastButtonTapped () {
        let text = roomView?.options[3].text
        if text == "Look At" {
            delegate?.optionWasTapped("East")
        } else {
            //??
        }
    }
    
    //    func displayText (_ text : String) {
    //        roomView?.displayText(text)
    //    }
    //
    //    func displayOptions () {
    //        roomView?.displayOptions()
    //    }
    
}

extension RoomViewController : RoomViewDelegate {
    func didTapRoomName() {
        delegate?.didTapRoomName()
    }
    
    func moveToRoom(_ room: Room) {
        delegate?.moveToRoom(room)
    }
    
    
}

protocol RoomViewControllerDelegate : RoomViewDelegate {
    func optionWasTapped (_ option : String)
    //??
    
}

