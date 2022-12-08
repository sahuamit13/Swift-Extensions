import UIKit
extension CGFloat {
    /**
     Converts pixels to points based on the screen scale. For example, if you
     call CGFloat(1).pixelsToPoints() on an @2x device, this method will return
     0.5.
     
     - parameter pixels: to be converted into points
     
     - returns: a points representation of the pixels
     */
    var toPoints: CGFloat {
        return self / UIScreen.main.scale
    }
    
    /**
     Returns the number of points needed to make a 1 pixel line, based on the
     scale of the device's screen.
     
     - returns: the number of points needed to make a 1 pixel line
     */
    static var onePixelInPoints: CGFloat {
        return CGFloat(1).toPoints
    }
    /**
    generate random Number
    */
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    /**
    convert value to two decimal place string
    */
    var twoDecimalPlaceString:String{
        return String(format: "%.2f", self)
    }
}
