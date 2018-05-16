//Finally a simple class!
//The inventory keeps track of the object in the main character's backpack.
//Items are stored as strings to reduce the number of objects instantiated,
//and to maintain the state of the object when changing rooms and locations.

class Inventory {
    
    var items = [String]()
    
    func addItem (_ item : String) {
        items.append(item)
    }
    
    func removeItem (_ name : String) {
        items = items.filter { item in
            item != name
        }
    }
    
}
