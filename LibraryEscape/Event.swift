//The event protocol. Oh boy.
//I may have been to ambitious with my design of this protocol.
//Each object has multiple events depending on the action performed upon it.
//The events can run multiple times, and change the state of the game, room, and the object

protocol Event {
    
    var eventText : String {get set}
    
    var eventCount : Int {get set}
    
    mutating func runEvent (in room : Room, for object : Object )
    
}

class CellphoneUse : Event {
    var eventText = "I wish I could. It's dead, and I don't have a charger."
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        
    }
}

class StudyRoomBKeyLookAt : Event {
    var eventText = "There's something shiny under one of the chairs. I should take a closer look."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        switch eventCount {
        case 0:
            eventText = "It looks like a key. I have no idea what it's for or how it got here."
        case 1:
            object.objectName = "Study Room Key"
            object.PickUpEvent = StudyRoomBKeyPickUp()
            eventText = "Yep, it's a key. It looks like it might fit into the door handle lock."
        default:
            eventText = "A key. Keys are used to open doors. There is a door in the room."
        }
        eventCount += 1
    }
}

class StudyRoomBKeyPickUp : Event {
    var eventText = "I pick up the key and examine it closely. I should try it on the door."
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        room.removeObject("Study Room B Key")
        room.inventory?.addItem("Study Room B Key")
        object.UseEvent = StudyRoomBKeyUse()
    }
}

class StudyRoomBKeyUse : Event {
    var eventText = "I fumble with the key for a moment but the door unlocks after a few attempts. Finally!"
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        room.inventory?.removeItem("Study Room B Key")
        room.exits[.North] = "Study Commons West"
        room.roomDescription = "It's the study room I fell asleep in. I don't know why I came back here."
        room.thoughtText = "The door's unlocked now. I don't see anything else that could help me."
        ObjectDictionary["Study Room Exit"]!.LookAtEvent?.eventText = "The door's unlocked now. I'm not sure why the key was inside the room."
        ObjectDictionary["Study Room Exit"]!.InteractEvent?.eventText = "I give the handle a few good turns. Yup, unlocked."
        ObjectDictionary["Study Room Exit"]!.InteractEvent?.eventCount = -1
    }
}

class StudyRoomBDoorLookAt : Event {
    var eventText = "It's the study room's door. I don't remember closing it."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
    }
}

class StudyRoomBDoorInteract : Event {
    var eventText = "I attempt to turn the door handle but I'm met with resistance. It's locked. Now what?"
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        if eventCount == 0 {
            eventText = "I violently shake the handle, to no avail. Am I really stuck in here?"
            room.thoughtText = "Someone should come open the door in the morning. Wait, isn't it Spring Break? Uh oh."
        }
    }
}

class ComputersLookAt : Event {
    var eventText = "It's a weird feeling to see all of these computers empty for once. I don't have time to sit down, however."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        
    }
}

class ComputersInteract : Event {
    var eventText = "It's a weird feeling to see all of these computers empty for once. I don't have time to sit down, however."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        
    }
}

class StudyCommonsExitLookAt : Event {
    var eventText = "There's the exit! I hope it's not too cold outside."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        
    }
}

class StudyCommonsExitInteract : Event {
    var eventText = "I push on the doors only for them to be locked as well. Are you serious?"
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        if eventCount == 0 {
            eventText = "I try putting more weight on the doors. It's no use. Any more and I'll be charged for destruction of property."
            room.thoughtText = "I'm stuck once again. Maybe there's a key somewhere in the Study Commons."
            room.exits[.South] = "Elevators Ground Floor"
            ObjectDictionary["Computers"]!.LookAtEvent?.eventText = "No luck here. All of the computers are offline. I can't log in."
            ObjectDictionary["Study Room Doors"]!.LookAtEvent?.eventText = "I should revisit these study rooms again. Maybe one of them is unlocked."
            ObjectDictionary["Study Room Doors"]!.LookAtEvent?.eventCount = 1
            ObjectDictionary["Study Commons Exit"]!.LookAtEvent?.eventText = "Who designed this building? Locked doors shouldn't block someone on the inside."
            eventCount += 1
        }
    }
}

class StudyRoomDoorsLookAt : Event {
    var eventText = "More study rooms line the walls. I'd rather not go into another one right now."
    
    var eventCount = 0
    func runEvent(in room: Room, for object: Object) {
        switch eventCount {
        case 1:
            eventText = "All of them are locked, except for Study Room M. Who hired the security guard here?"
            eventCount += 1
        case 2:
            eventText = "The door to the study room is unlocked. I should search inside."
            object.objectName = "Study Room M Door"
            room.exits[.North] = "Study Commons Room M"
        default:
            break
        }
    }
}

class ElevatorCallButtonLookAt : Event {
    var eventText = "It's a call button for the elevators. I'm drawn to its warm comforting light."
    
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        eventText = "It's a call button for the elevators. Should I push it again?"
    }
}

class ElevatorCallButtonInteract : Event {
    var eventText = "I push the button no less than ten times. At last the bell rings and the doors open."
    
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        eventText = "I've pushed it enough, as fun as it can be."
        ObjectDictionary["Elevator"]!.objectName = "Elevator"
        ObjectDictionary["Elevator"]!.LookAtEvent = ElevatorLookAt()
        ObjectDictionary["Elevator"]!.InteractEvent = ElevatorInteract()
    }
}

class ElevatorLookAt : Event {
    var eventText = "It's an elevator. I should hurry before the doors close."
    
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        if eventCount == 0 {
            eventText = "It's tempting to let the doors close so that I could push the button again..."
        }
    }
}

class ElevatorInteract : Event {
    var eventText = "I enter the doors just as they close to embrace me. I've made it!"
    
    var eventCount = 0
    
    func runEvent(in room: Room, for object: Object) {
        room.exits[.North] = "Final Room"
        room.removeObject("Elevator Call Button")
        object.InteractEvent = nil
        object.LookAtEvent?.eventText = "It looks like I've arrived, time to head home."
        object.LookAtEvent?.eventCount = 1
        room.thoughtText = "Maybe I should press all of the elevator buttons just in case."
    }
}
