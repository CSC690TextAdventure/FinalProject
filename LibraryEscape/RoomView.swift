import UIKit

public class RoomView : UIView {
    
    var roomButtons : [RoomButtonLabel] = (1...4).map {_ in RoomButtonLabel()}
    var textField : RoomNameLabel

    let room : Room
    
    init(_ room : Room) {
        self.room = room
        textField = RoomNameLabel(room.roomName)
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        addSubview(textField)
        roomButtons.forEach {button in addSubview(button)}
        displayButtons()
        alignLabels()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func alignLabels() {
        
        roomButtons[0].align(.top, constant: 5)
        roomButtons[0].align(.left, constant: UIScreen.main.bounds.width / 2 - RoomButtonLabel.buttonLength / 2)
        
        roomButtons[1].align(.left, constant: 5)
        roomButtons[1].align(.top, constant: UIScreen.main.bounds.height / 4 - RoomButtonLabel.buttonLength / 2)
        
        roomButtons[2].align(.bottom, constant: -5)
        roomButtons[2].align(.left, constant: UIScreen.main.bounds.width / 2 - RoomButtonLabel.buttonLength / 2)
        
        roomButtons[3].align(.right, constant: -5)
        roomButtons[3].align(.top, constant: UIScreen.main.bounds.height / 4 - RoomButtonLabel.buttonLength / 2)
        
    }
    
    func displayButtons (_ Text : [String] = ["North", "West", "South", "East"]) {
        for i in 0..<(min(roomButtons.count, 4)) {
            roomButtons[i].text = Text[i]
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
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
        textAlignment = .center
        numberOfLines = 3
        textRect(forBounds: CGRect(x: UIScreen.main.bounds.width / 3, y: UIScreen.main.bounds.height / 8, width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.height / 4), limitedToNumberOfLines: 3)
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}

class RoomButtonLabel : UILabel {
    static let buttonLength = UIScreen.main.bounds.height / 10
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: RoomButtonLabel.buttonLength)
        setWidth(to: RoomButtonLabel.buttonLength)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}

