
import UIKit

public class RoomView : UIView {
    
    var delegate : RoomViewDelegate?
    let room : Room
    
    init(_ room : Room) {
        self.room = room
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
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
