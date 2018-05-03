//
//  RoomViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    var currentRoom : Room!
    
    var topView : UIView?
    var bottomView : StoryView?
    
    
    let key = StudyRoomBKey()
    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentRoom = StudyRoomB()
    }
    
    func displayRoomView(for room : Room) {
        //topView = RoomView(room)
    }
    
    func changeRoom (to room : Room) {
        displayRoomView(for: room)
    }
    
    func displayText (_ text: String) {
        //bottomView.textLabel.text = text;
    }
    
    @IBAction func LookAt(_ sender: UIButton) {
        Text.text = key.LookAtEvent?.eventText
        key.LookAtEvent?.runEvent(in: currentRoom, for: key)
    }
}
