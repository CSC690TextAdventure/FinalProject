import UIKit

class RoomViewController: UIViewController {
    
    var room : Room
    var delegate : RoomViewControllerDelegate?
    var roomView : RoomView?
    
    init(_ room : Room) {
        self.room = room
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.room = StudyRoomB()
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        roomView = RoomView(room)
        
        let northTap = UITapGestureRecognizer(target: self, action: #selector(northButtonTapped))
        let westTap = UITapGestureRecognizer(target: self, action: #selector(westButtonTapped))
        let southTap = UITapGestureRecognizer(target: self, action: #selector(southButtonTapped))
        let eastTap = UITapGestureRecognizer(target: self, action: #selector(eastButtonTapped))
        
        roomView?.textField.isUserInteractionEnabled = true
        roomView?.roomButtons.forEach {button in
            button.isUserInteractionEnabled = true
        }
        
        roomView?.roomButtons[0].addGestureRecognizer(northTap)
        roomView?.roomButtons[1].addGestureRecognizer(westTap)
        roomView?.roomButtons[2].addGestureRecognizer(southTap)
        roomView?.roomButtons[3].addGestureRecognizer(eastTap)
        
        updateButtons()
        
        self.view = roomView!
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func northButtonTapped () {
        if room.exits[.North] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.North]!]!)
        }
    }
    
    @objc func westButtonTapped () {
        if room.exits[.West] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.West]!]!)
        }
    }
    
    @objc func southButtonTapped () {
        if room.exits[.South] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.South]!]!)
        }
    }
    
    @objc func eastButtonTapped () {
        if room.exits[.East] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.East]!]!)
        }
    }
    
    func updateButtons() {
        roomView?.roomButtons[0].isHidden = (room.exits[.North] == nil)
        roomView?.roomButtons[1].isHidden = (room.exits[.West] == nil)
        roomView?.roomButtons[2].isHidden = (room.exits[.South] == nil)
        roomView?.roomButtons[3].isHidden = (room.exits[.East] == nil)
    }
    
}

protocol RoomViewControllerDelegate {
    func didTapRoomName(_ room : Room)
    func moveToRoom(_ room : Room)
}

