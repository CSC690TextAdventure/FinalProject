//
//  RoomViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

extension UIView {
    
}

class RoomViewController: UIViewController {
    
    
    let room = StudyRoomB()
    let key = StudyRoomBKey()
    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func LookAt(_ sender: UIButton) {
        Text.text = key.LookAtEvent?.eventText
        key.LookAtEvent?.runEvent(in: room, for: key)
    }
}
