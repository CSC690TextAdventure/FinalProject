import UIKit


// The GameViewController is the app's main class. It manages
// all of the view controllers and subviews on the game screen.
// The top half consists of either a Room View or a Map View.
// The bottom half always displays the Story View
class GameViewController: UIViewController {
    
    var currentRoom : Room = RoomDictionary["Study Commons Room B"]!
    let currentInventory = Inventory()
    
    // All of the views and view controllers
    var roomViewController : RoomViewController?
    var mapView : MapView?
    var inventoryViewController : InventoryViewController?
    var storyViewController : StoryViewController?
    
    // The two buttons that switch between top views.
    var roomViewLabel : ViewLabel = ViewLabel("Room")
    var mapViewLabel: ViewLabel = ViewLabel("Map")
    var inventoryViewLabel: ViewLabel = ViewLabel("Pack")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //We display the story view and the room view by moving to the first Room.
        displayStoryView()
        currentInventory.addItem("Cellphone")
        moveToRoom(currentRoom)
        
        //Setup for the two view buttons
        let roomViewTap = UITapGestureRecognizer(target: self, action: #selector(self.roomViewTapped))
        let mapViewTap = UITapGestureRecognizer(target: self, action: #selector(self.mapViewTapped))
        
        let inventoryViewTap = UITapGestureRecognizer(target: self, action: #selector(self.inventoryViewTapped))
        roomViewLabel.isUserInteractionEnabled = true
        mapViewLabel.isUserInteractionEnabled = true
        inventoryViewLabel.isUserInteractionEnabled = true
        
        roomViewLabel.addGestureRecognizer(roomViewTap)
        mapViewLabel.addGestureRecognizer(mapViewTap)
        inventoryViewLabel.addGestureRecognizer(inventoryViewTap)
        
        //adding the buttons to the view.f
        self.view.addSubview(roomViewLabel)
        self.view.addSubview(mapViewLabel)
        self.view.addSubview(inventoryViewLabel)
        
    }
    
    // When we display a view, we first remove the current top view.
    // We then add the desired view controller and subview to the main view.
    // We align it to the top of the main view, and finally re-display the buttons.
    func displayRoomView() {
        removeCurrentView()
        roomViewController = RoomViewController(currentRoom)
        self.addChildViewController(roomViewController!)
        roomViewController?.delegate = self
        let roomView = roomViewController?.view
        self.view.addSubview(roomView!)
        alignTopView(roomView!)
        displayText(currentRoom.roomDescription)
        displayViewLabels()
    }
    
    
    func displayMapView() {
        removeCurrentView()
        mapView = MapView()
        self.view.addSubview(mapView!)
        alignTopView(mapView!)
        displayViewLabels()
    }
    
    //Currently unused, but working.
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
    
    //The story view is only displayed once, as it never gets swapped out.
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
    
    // Only removes the top views. Optional chaining allows us to call all three methods safely.
    func removeCurrentView() {
        roomViewController?.removeFromParentViewController()
        mapView?.removeFromSuperview()
        inventoryViewController?.removeFromParentViewController()
    }
    
    //See extensions at the bottom of this class file.
    func alignTopView(_ view : UIView) {
        view.align(.top)
        view.align(.leading)
        view.align(.trailing)
    }
    
    //This will display text to the story view's text field.
    func displayText (_ text: String) {
        storyViewController?.displayText(text)
    }
    
    //Functions specific to the view buttons in the top view, which are always visible.
    @objc func roomViewTapped() {
        displayRoomView()
        displayViewLabels()
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
    @objc func mapViewTapped() {
        displayMapView()
        displayViewLabels()
    }
    
    @objc func inventoryViewTapped() {
        displayInventoryView()
        displayViewLabels()
    }
    
    func displayViewLabels() {
        roomViewLabel.removeFromSuperview()
        mapViewLabel.removeFromSuperview()
        inventoryViewLabel.removeFromSuperview()
        self.view.addSubview(roomViewLabel)
        self.view.addSubview(mapViewLabel)
        self.view.addSubview(inventoryViewLabel)
        alignViewLabels()
    }
    
    func alignViewLabels() {
        roomViewLabel.align(.bottom, constant: -(UIScreen.main.bounds.height / 2 + 5))
        mapViewLabel.align(.bottom, constant: -(UIScreen.main.bounds.height / 2 + 5))
        roomViewLabel.align(.left, constant: 5)
        mapViewLabel.align(.right, constant: -5)
        inventoryViewLabel.align(.top, constant: 5)
        inventoryViewLabel.align(.left, constant: 5)
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

// GameViewController is also a StoryViewControllerDelegate,
// and responds to the StoryViewController's request to change the display.
// The StoryViewController is responsible for passing the event information to the delegate.
extension GameViewController : StoryViewControllerDelegate {
    
    //Switches over the text that was tapped on.
    //If it is one of six actions, an event flag is raised in StoryViewController.
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
    
    //This will be called if the relevant event flag is raised.
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
    
    //This will be called if the relevant event flag is raised.
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
    
    //This will be called if the relevant event flag is raised.
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
    
    //This will be called if the relevant event flag is raised.
    func thoughtsWasTapped() {
        displayText(currentRoom.thoughtText)
        storyViewController?.currentEvent = ""
        storyViewController?.displayOptions()
    }
    
}

//These extensions borrowed and modified from class lectures. Thank you, they were extremely helpful.
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
