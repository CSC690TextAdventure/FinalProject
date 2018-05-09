
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
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    func didTapButton(button: UILabel) {
        if room.exits[.North] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.North]!]!)
        }
    }
    
}

protocol RoomViewDelegate {
    func didTapRoomName(_ room : Room)
    func moveToRoom(_ room : Room)
}
