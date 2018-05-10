
import UIKit

public class RoomView : UIView {
    
    var delegate : RoomViewDelegate?
    let room : Room
    
    init(_ room : Room) {
        self.room = room
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        backgroundColor = UIColor.red
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
        let textField : RoomNameLabel = RoomNameLabel(room.roomName)//
        addSubview(textField)    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
//    func displayText(_ text : String) {
//        textField2.text = text
//    }
    
    
    func didTapButton(button: UILabel) {
        if room.exits[.North] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.North]!]!)
        }
    }
    
}

class RoomNameLabel : UILabel {
    init(_ text: String) {
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        setWidth(to: UIScreen.main.bounds.width)
        backgroundColor = UIColor.yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3.0
        textAlignment = .center
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}

protocol RoomViewDelegate {
    func didTapRoomName(_ room : Room)
    func moveToRoom(_ room : Room)
}
