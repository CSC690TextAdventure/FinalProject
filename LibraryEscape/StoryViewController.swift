import UIKit


//Story View Controller maintains the Story View and passes touch information to its delegate,
// in this case GameViewController. 6 UILabels make up the options that the player can touch.
// Each label has its own UITapGestureRecognizer and action function.
public class StoryViewController : UIViewController {
    
    var delegate : StoryViewControllerDelegate?
    var currentEvent : String = ""
    var storyView : StoryView?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        storyView = StoryView()
        
        let lookAtTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.lookAtTapped))
        
        let pickUpTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.pickUpTapped))
        
        let interactTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.interactTapped))
        
        let useTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.useTapped))
        
        let moveToTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.moveToTapped))
        
        let thoughtsTap = UITapGestureRecognizer(target: self, action: #selector(StoryViewController.thoughtsTapped))
        
        storyView?.options.forEach {option in
            option.isUserInteractionEnabled = true
        }
        
        storyView?.options[0].addGestureRecognizer(lookAtTap)
        storyView?.options[1].addGestureRecognizer(pickUpTap)
        storyView?.options[2].addGestureRecognizer(interactTap)
        storyView?.options[3].addGestureRecognizer(useTap)
        storyView?.options[4].addGestureRecognizer(moveToTap)
        storyView?.options[5].addGestureRecognizer(thoughtsTap)
        
        self.view = storyView!
    }
    
    @objc func lookAtTapped () {
        let text = storyView?.options[0].text
        if text == "Look At" {
            delegate?.optionWasTapped("Look At")
        } else {
            runEvent(text!)
        }
    }
    
    @objc func pickUpTapped () {
        let text = storyView?.options[1].text
        if text == "Pick Up" {
            delegate?.optionWasTapped("Pick Up")
        } else {
            runEvent(text!)
        }
    }
    
    @objc func interactTapped () {
        let text = storyView?.options[2].text
        if text == "Interact" {
            delegate?.optionWasTapped("Interact")
        } else {
            runEvent(text!)
        }
        
    }
    
    @objc func useTapped () {
        let text = storyView?.options[3].text
        if text == "Use" {
            delegate?.optionWasTapped("Use")
        } else {
            runEvent(text!)
        }
    }
    
    @objc func moveToTapped () {
        let text = storyView?.options[4].text
        if text == "Move To" {
            delegate?.optionWasTapped("Move To")
        } else {
            runEvent(text!)
        }
    }
    
    @objc func thoughtsTapped () {
        let text = storyView?.options[5].text
        if text == "Thoughts" {
            delegate?.optionWasTapped("Thoughts")
        } else {
            runEvent(text!)
        }
    }
    
    func runEvent(_ text : String) {
        switch currentEvent {
        case "Look At", "Pick Up", "Interact":
            delegate?.eventWasTapped(currentEvent, for: text)
        case "Use":
            delegate?.useWasTapped(for: text)
        case "Move To":
            delegate?.moveToWasTapped(for: text)
        case "Thoughts":
            delegate?.thoughtsWasTapped()
        default:
            currentEvent = ""
            displayOptions()
        }
    }
    
    func displayText (_ text : String) {
        storyView?.displayText(text)
    }
    
    func displayOptions () {
        storyView?.displayOptions()
    }
    
    func displayItems (_ items : [String]) {
        storyView?.displayOptions(items)
    }
    
}

protocol StoryViewControllerDelegate {
    func optionWasTapped (_ option : String)
    func eventWasTapped (_ event : String, for objectName : String)
    func useWasTapped (for objectName : String)
    func moveToWasTapped (for roomName : String)
    func thoughtsWasTapped ()
}
