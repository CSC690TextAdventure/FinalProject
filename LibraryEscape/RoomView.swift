
import UIKit

public class RoomView : UIView {
    
    var options : [OptionLabel] = (1...4).map {_ in OptionLabel()}
    var delegate : RoomViewDelegate?
    var textField : TextLabel = TextLabel()
    let room : Room
    
    init(_ room : Room) {
        self.room = room
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        backgroundColor = UIColor.red
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3.0
        let textField : RoomNameLabel = RoomNameLabel(room.roomName)//
        addSubview(textField)
        options.forEach {option in addSubview(option)}
        alignLabels()
        displayOptions()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    //    func displayText(_ text : String) {
    //        textField2.text = text
    //    }
    
    //need changed for correct positions
    func alignLabels() {
        textField.align(.top)
        textField.align(.leading)
        textField.align(.trailing)
        
        options[0].align(.leading)
        options[0].connectTop(to: textField)
        options[0].connectRight(to: options[1])
        
        options[1].connectTop(to: textField)
        options[1].connectRight(to: options[2])
        
        options[2].connectTop(to: textField)
        options[2].align(.trailing)
        
        options[3].align(.leading)
        options[3].connectRight(to: options[4])
        options[3].align(.bottom)
        
    }
    
    func displayOptions (_ optionText : [String] = ["North", "West", "South", "East"]) {
        clearOptions()
        for i in 0..<(min(optionText.count, 4)) {
            options[i].text = optionText[i]
        }
    }
    
    func clearOptions() {
        options.forEach {option in option.text = ""}
    }
    
    func didTapNorthButton() {
        if room.exits[.North] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.North]!]!)
        }
    }
    
    func didTapWestButton() {
        if room.exits[.West] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.West]!]!)
        }
    }
    
    func didTapSouthButton() {
        if room.exits[.South] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.South]!]!)
        }
    }
    
    func didTapEastButton() {
        if room.exits[.East] != nil {
            delegate?.moveToRoom(RoomDictionary[room.exits[.East]!]!)
        }
    }
    
    func didTapRoomName(){
        delegate?.didTapRoomName()
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
    func didTapRoomName()
    func moveToRoom(_ room : Room)
}

