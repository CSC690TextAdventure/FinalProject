import UIKit


class MapView : UIScrollView {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setHeight(to: UIScreen.main.bounds.height / 2)
        
        let imageWidth:CGFloat = UIScreen.main.bounds.width * 2 * 3 / 4
        let imageHeight:CGFloat = UIScreen.main.bounds.height * 3 / 4
        
        let myImage:UIImage = UIImage(named: "MapView_5")!
        let myImageView:UIImageView = UIImageView()
        
        myImageView.image = myImage
        
        myImageView.frame.size.width = imageWidth
        myImageView.frame.size.height = imageHeight
        myImageView.frame.origin.x = -50
        myImageView.frame.origin.y = -100
        
        self.addSubview(myImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
