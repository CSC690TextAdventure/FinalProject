import UIKit


class MapView : UIScrollView {
    init(name : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let height = UIScreen.main.bounds.height / 2
        let width = UIScreen.main.bounds.width
        
        
        let roomName : UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        roomName.text = name
        
        let myImages = ["MapView_Start, MapView_1, MapView_2,MapView_3,MapView_4,MapView_5, MapView_6, MapView_7, MapView_8, MapView_9, MapView_10, MapView_Finish" ]
        let imageWidth:CGFloat = 66
        let imageHeight:CGFloat = 66
        var xPosition:CGFloat = 0
        var scrollViewSize:CGFloat=0
        
        for image in myImages {
            let myImage:UIImage = UIImage(named: image)!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            
            let LongTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "Map View:")
            LongTapGestureRecognizer.minimumPressDuration = 1.0;
            myImageView.addGestureRecognizer(LongTapGestureRecognizer)
            myImageView.isUserInteractionEnabled = true
            
            myImageView.frame.size.width = imageWidth
            myImageView.frame.size.height = imageHeight
            myImageView.frame.origin.x = xPosition
            myImageView.frame.origin.y = 0
            
            //ScrollViewFreunde.addSubview(myImageView)
            //ScrollViewFreunde.showsHorizontalScrollIndicator = false
            xPosition += imageWidth
            scrollViewSize += imageWidth
        }
        //ScrollViewFreunde.contentSize = CGSize(width: imageWidth, height: imageHeight)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveTo(room : Room) {
        
        
    }
    
    //override func scrollRectToVisible(_ rect: CGRect, animated: Bool)
    override func scrollRectToVisible(_ rect: CGRect, _:!(x: roomName.xCoord, y: roomName.yCoord, width: width, height: height), animated: true)
    
    
    
    
}


