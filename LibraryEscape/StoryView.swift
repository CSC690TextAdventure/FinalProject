//
//  StoryView.swift
//  LibraryGame
//
//  Created by Scott Penn on 5/3/18.
//  Copyright © 2018 Scott Bot Industries. All rights reserved.
//

import UIKit

class StoryView : UIView {
    
    var options : [OptionLabel] = (1...6).map {number in OptionLabel(number)}
    var textField : TextLabel = TextLabel()
    
    
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 2)
        backgroundColor = UIColor.blue
        
        addSubview(textField)
        options.forEach {option in addSubview(option)}
        alignLabels()
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
    
    func displayText(_ text : String) {
        textField.text = text
    }

    
}

class TextLabel : UILabel {
    init() {
        super.init(frame: CGRect.zero)
        setHeight(to: UIScreen.main.bounds.height / 6)
        backgroundColor = UIColor.green
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3.0
        textAlignment = .center
        text = "Sample text!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}

extension UILabel {
    func setupTheme() {
        
    }
}

class OptionLabel : UILabel {
    
    static let height = UIScreen.main.bounds.height / 6
    static let width = UIScreen.main.bounds.width / 3
    
    init(_ id : Int) {
        super.init(frame: CGRect.zero)
        setHeight(to: OptionLabel.height)
        setWidth(to: OptionLabel.width)
        backgroundColor = UIColor.cyan
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3.0
        textAlignment = .center
        text = String(id)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }
}
