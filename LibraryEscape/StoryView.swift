//
//  StoryView.swift
//  LibraryGame
//
//  Created by Scott Penn on 5/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class StoryView : UIView {
    
    var options : [OptionLabel] = (1...6).map {_ in OptionLabel()}
    var textField : TextLabel = TextLabel()
    
    
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        
        addSubview(textField)
        options.forEach {option in addSubview(option)}
        alignLabels()
        displayOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
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
        
        options[4].connectRight(to: options[5])
        options[4].align(.bottom)
        
        options[5].align(.trailing)
        options[5].align(.bottom)
    }
    
    func displayOptions (_ optionText : [String] = ["Look At", "Pick Up", "Interact", "Use", "Move To", "Thoughts"]) {
        clearOptions()
        for i in 0..<(min(optionText.count, 6)) {
            options[i].text = optionText[i]
        }
    }
    
    func clearOptions() {
        options.forEach {option in option.text = ""}
    }
    
    func displayText(_ text : String) {
        textField.text = text
    }

    
}

class TextLabel : UILabel {
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 6)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
        numberOfLines = 3;
        textAlignment = .natural
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

class OptionLabel : UILabel {
    
    static let height = UIScreen.main.bounds.height / 6
    static let width = UIScreen.main.bounds.width / 3
    
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: OptionLabel.height)
        setWidth(to: OptionLabel.width)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.1618045275, green: 0.9652485427, blue: 0.0007898631764, alpha: 1)
        layer.borderWidth = 1.0
        numberOfLines = 3;
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}
