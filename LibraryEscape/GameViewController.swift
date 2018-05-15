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
    var mapView : MapView?
    var inventoryViewController : InventoryViewController?
    var storyViewController : StoryViewController?
    
    var roomViewLabel : ViewLabel = ViewLabel("Room")
    var mapViewLabel: ViewLabel = ViewLabel("Map")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayStoryView()
        currentInventory.addItem("Cellphone")
        moveToRoom(currentRoom)
        
        let roomViewTap = UITapGestureRecognizer(target: self, action: #selector(self.roomViewTapped))
        
        let mapViewTap = UITapGestureRecognizer(target: self, action: #selector(self.mapViewTapped))
        
        roomViewLabel.isUserInteractionEnabled = true
        mapViewLabel.isUserInteractionEnabled = true
        
        roomViewLabel.addGestureRecognizer(roomViewTap)
        mapViewLabel.addGestureRecognizer(mapViewTap)
        
        self.view.addSubview(roomViewLabel)
        self.view.addSubview(mapViewLabel)
        
    }
    
    
    
    func displayRoomView() {
        removeCurrentView()
        roomViewController = RoomViewController(currentRoom)
        self.addChildViewController(roomViewController!)
        roomViewController?.delegate = self
        let roomView = roomViewController?.view
        self.view.addSubview(roomView!)
        alignTopView(roomView!)
        displayViewLabels()
    }
    
    func displayMapView() {
        removeCurrentView()
        mapView = MapView()
        self.view.addSubview(mapView!)
        alignTopView(mapView!)
        displayViewLabels()
    }
    
    func displayInventoryView() {
        removeCurrentView()
        inventoryViewController = InventoryViewController(currentInventory)
        self.addChildViewController(inventoryViewController!)
        inventoryViewController?.delegate = self
        let inventoryTableView = inventoryViewController?.tableView
        self.view.addSubview(inventoryTableView!)
        alignTopView(inventoryTableView!)
        displayViewLabels()
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
        mapView?.removeFromSuperview()
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
    
    @objc func roomViewTapped() {
        displayRoomView()
        displayViewLabels()
    }
    
    @objc func mapViewTapped() {
        displayMapView()
        displayViewLabels()
    }
    
    func displayViewLabels() {
        roomViewLabel.removeFromSuperview()
        mapViewLabel.removeFromSuperview()
        self.view.addSubview(roomViewLabel)
        self.view.addSubview(mapViewLabel)
        alignViewLabels()
    }
    
    func alignViewLabels() {
        roomViewLabel.align(.bottom, constant: -(UIScreen.main.bounds.height / 2 + 5))
        mapViewLabel.align(.bottom, constant: -(UIScreen.main.bounds.height / 2 + 5))
        roomViewLabel.align(.left, constant: 5)
        mapViewLabel.align(.right, constant: -5)
    }
    
}

class ViewLabel : UILabel {
    
    static let height = UIScreen.main.bounds.height / 10
    static let width = UIScreen.main.bounds.width / 10
    
    init(_ name : String) {
        super.init(frame: CGRect.zero)
        setHeight(to: ViewLabel.height)
        setWidth(to: ViewLabel.height)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
        numberOfLines = 1;
        textAlignment = .center
        text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
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
        roomViewController?.updateButtons()
    }
    
    func useWasTapped(for objectName: String) {
        let objects = currentInventory.items.compactMap {ObjectDictionary[$0]}
        let object = objects.filter {$0.objectName == objectName}.first
        var tappedEvent = object?.UseEvent
        displayText(tappedEvent?.eventText ?? "I can't use that...")
        tappedEvent?.runEvent(in: currentRoom, for: object!)
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
        roomViewController?.updateButtons()
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
        roomViewController?.updateButtons()
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
