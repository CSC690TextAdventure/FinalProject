//
//  GameViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentRoom : Room = StudyRoomB()
    let currentInventory = Inventory()
    
    var roomViewController : RoomViewController?
    //var mapViewController : MapViewController?
    var inventoryViewController : InventoryViewController?
    var storyView : StoryView?
    
    @IBOutlet weak var Text: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayRoomView()
        displayStoryView()
        displayInventoryView()
        
        currentInventory.addItem(StudyRoomBKey())
    }
    
    func displayRoomView() {
        removeCurrentView()
        roomViewController = RoomViewController(currentRoom)
        self.addChildViewController(roomViewController!)
        roomViewController?.delegate = self
        let roomView = roomViewController?.view
        self.view.addSubview(roomView!)
        alignTopView(roomView!)
    }
    
    func displayMapView() {
        //removeCurrentView()
        //mapView = MapView()
        //mapView?.delegate = self
        //alignTopView()
    }
    
    func displayInventoryView() {
        removeCurrentView()
        inventoryViewController = InventoryViewController(currentInventory)
        self.addChildViewController(inventoryViewController!)
        inventoryViewController?.delegate = self
        let inventoryTableView = inventoryViewController?.tableView
        self.view.addSubview(inventoryTableView!)
        alignTopView(inventoryTableView!)
    }
    
    func displayStoryView() {
        storyView = StoryView()
        self.view.addSubview(storyView!)
        storyView?.align(.leading)
        storyView?.align(.trailing)
        storyView?.align(.bottom)
    }
    
    func removeCurrentView() {
        roomViewController?.removeFromParentViewController()
        //mapView?.removeFromSuperView()
        inventoryViewController?.removeFromParentViewController()
    }
    
    func alignTopView(_ view : UIView) {
        view.align(.top)
        view.align(.leading)
        view.align(.trailing)
    }
    
    func displayText (_ text: String) {
        storyView?.displayText(text)
    }
    
}

extension GameViewController : RoomViewControllerDelegate {
    func didTapRoomName(_ room : Room) {
        displayText(room.roomDescription)
    }
    
    func moveToRoom(_ room : Room) {
        currentRoom = room
        displayRoomView()
    }
}

//This is the delegate extension where we implement InventoryViewControllerDelegate functions
//I have already implemented the only one I think we'll need.
//It just displays the item's description to the StoryView's text field.
extension GameViewController : InventoryViewControllerDelegate {
    func inventoryItemWasTapped(_ item : Object) {
        displayText(item.inventoryText)
    }
}

//extension RoomViewController : MapViewDelegate {}



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
