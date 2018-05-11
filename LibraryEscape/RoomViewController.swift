//
//  RoomViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    
    var currentRoom : Room = StudyRoomB()
    let currentInventory = Inventory()
    
    var topView : UIView?
    var bottomView : StoryView?
    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTopView()
        initializeBottomView()
        displayInventoryView()
        
        currentInventory.addItem(StudyRoomBKey())
    }
    
    func displayRoomView() {
        topView = RoomView(currentRoom)
        let roomView = topView as! RoomView
        roomView.delegate = self
        alignTopView()
        self.view.setNeedsDisplay()
    }
    
    func displayMapView() {
        //topView = MapView()
        //let mapView = topView as! MapView
        //mapView.delegate = self
        //alignTopView()
        //self.view.setNeedsDisplay()
    }
    
    func displayInventoryView() {
        topView?.removeFromSuperview()
        topView = InventoryView(currentInventory)
        self.view.addSubview(topView!)
        let inventoryView = topView as! InventoryView
        inventoryView.delegate = self
        alignTopView()
        self.view.setNeedsDisplay()
    }
    
    func initializeTopView() {
        topView = RoomView(currentRoom)
        self.view.addSubview(topView!)
        alignTopView()
    }
    
    func alignTopView() {
        topView?.align(.top)
        topView?.align(.leading)
        topView?.align(.trailing)
    }
    
    func initializeBottomView() {
        bottomView = StoryView()
        self.view.addSubview(bottomView!)
        bottomView?.align(.leading)
        bottomView?.align(.trailing)
        bottomView?.align(.bottom)
    }
    
    func displayText (_ text: String) {
        bottomView?.displayText(text)
    }
    
}

extension RoomViewController : RoomViewDelegate {
    func didTapRoomName(_ room : Room) {
        displayText(room.roomDescription)
    }
    
    func moveToRoom(_ room : Room) {
        currentRoom = room
        displayRoomView()
    }
}

//extension RoomViewController : MapViewDelegate {}

extension RoomViewController : UITableViewDelegate {
    
}


extension UIView {
    func setHeight(to height: CGFloat) {
        NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setWidth(to width: CGFloat) {
        NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: width).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func align(_ attribute: NSLayoutAttribute, constant: CGFloat = 0.0) {
        let otherView: UIView! = self.superview
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: otherView, attribute: attribute, multiplier: 1.0, constant: constant).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func connectRight(to view : UIView) {
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func connectTop(to view : UIView) {
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
