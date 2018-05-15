//
//  GameViewController.swift
//  LibraryEscape
//
//  Created by Scott Penn on 4/10/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var currentRoom : Room = RoomDictionary["Study Commons Room B"]!
    let currentInventory = Inventory()
    
    var roomViewController : RoomViewController?
    //var mapViewController : MapViewController?
    var inventoryViewController : InventoryViewController?
    var storyViewController : StoryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayStoryView()
        currentInventory.addItem("Cellphone")
        moveToRoom(currentRoom)
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
        storyViewController = StoryViewController()
        self.addChildViewController(storyViewController!)
        storyViewController?.delegate = self
        let storyView = storyViewController?.view
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
        storyViewController?.displayText(text)
    }
    
}

extension GameViewController : RoomViewControllerDelegate {
    func didTapRoomName(_ room : Room) {
        displayText(room.roomDescription)
    }
    
    func moveToRoom(_ room : Room) {
        currentRoom = room
        currentRoom.inventory = currentInventory
        displayRoomView()
        displayText(currentRoom.roomDescription)
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

//extension GameViewController : MapViewDelegate {}

extension GameViewController : StoryViewControllerDelegate {
    
    func optionWasTapped(_ option: String) {
        storyViewController?.currentEvent = option
        displayText(option)
        switch option {
        case "Look At", "Pick Up", "Interact":
            let objectNames = currentRoom.objects.compactMap {ObjectDictionary[$0]?.objectName}
            storyViewController?.displayItems(objectNames)
        case "Use":
            let itemNames = currentInventory.items.compactMap {ObjectDictionary[$0]?.objectName}
            storyViewController?.displayItems(itemNames)
        case "Move To":
            storyViewController?.displayItems(currentRoom.exits.values.map {$0})
        case "Thoughts":
            storyViewController?.displayText(currentRoom.thoughtText)
            storyViewController?.currentEvent = ""
        default:
            break
        }
    }
    
    func eventWasTapped (_ event : String, for objectName : String) {
        let objects = currentRoom.objects.compactMap {ObjectDictionary[$0]}
        let object = objects.filter {$0.objectName == objectName}.first
        var tappedEvent : Event?
        switch event {
        case "Look At":
            tappedEvent = object?.LookAtEvent
        case "Pick Up":
            tappedEvent = object?.PickUpEvent
        case "Interact":
            tappedEvent = object?.InteractEvent
        default:
            return
        }
        displayText(tappedEvent?.eventText ?? "I can't do that...")
        tappedEvent?.runEvent(in: currentRoom, for: object!)
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
    func useWasTapped(for objectName: String) {
        let objects = currentInventory.items.compactMap {ObjectDictionary[$0]}
        let object = objects.filter {$0.objectName == objectName}.first
        var tappedEvent = object?.UseEvent
        displayText(tappedEvent?.eventText ?? "I can't use that...")
        tappedEvent?.runEvent(in: currentRoom, for: object!)
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
    func moveToWasTapped(for roomName: String) {
        let exits = currentRoom.exits.values.compactMap {$0}
        let exit = exits.filter {roomName == $0}.first
        if let exit = exit, let room = RoomDictionary[exit] {
            moveToRoom(room)
        } else {
            displayText("I can't move there...")
        }
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
    func thoughtsWasTapped() {
        displayText(currentRoom.thoughtText)
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
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
