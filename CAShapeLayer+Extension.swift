import UIKit

extension CAShapeLayer {
    
    func addBorderShape(_ frame: CGRect, withCorner radius: CGFloat, strokeColor: UIColor = UIColor.black, borderWidth: CGFloat = 1.0) {
        
        let cornerRadius: CGFloat = radius
        
        let path: CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: frame.size.height - cornerRadius), transform: .identity)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius), transform: .identity)
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: .pi, endAngle: -(.pi/2), clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: frame.size.width - cornerRadius, y: 0), transform: .identity)
        path.addArc(center: CGPoint(x: frame.size.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -(.pi/2), endAngle: 0, clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height - cornerRadius), transform: .identity)
        path.addArc(center: CGPoint(x: frame.size.width - cornerRadius, y: frame.size.height - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: .pi/2, clockwise: false, transform: .identity)
        path.addLine(to: CGPoint(x: cornerRadius, y: frame.size.height), transform: .identity)
        path.addArc(center: CGPoint(x: cornerRadius, y: frame.size.height - cornerRadius), radius: cornerRadius, startAngle: .pi/2, endAngle: .pi, clockwise: false, transform: .identity)
        
        self.path = path
        self.backgroundColor = UIColor.clear.cgColor
        self.frame = frame
        self.masksToBounds = false
        self.setValue(0, forKey: "isCircle")
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = strokeColor.cgColor
        self.lineWidth = borderWidth
        self.lineDashPattern = [4, 4]
        self.lineCap = CAShapeLayerLineCap.round
    }
}
/**
// How to use
// E.g. Custom View

class CustomView: UIView {

    fileprivate let dottedBorder = CAShapeLayer()
    func prepareDottedBorder() {
       self.dottedBorder.addBorderShape(self.bounds, withCorner: 4.0)
       self.layer.addSublayer(self.dottedBorder)
    }


// E.g. Custom Collection view Cell
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
 
    let _border = CAShapeLayer()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    fileprivate func setup() {
        self.layer.cornerRadius = 4.0
        self.layer.addSublayer(_border)
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        _border.addBorderShape(self.bounds, withCorner: 4.0, strokeColor: .black)
    }
    
    func showBorder(show: Bool) {
        if !show {
            _border.strokeColor = UIColor.clear.cgColor
        } else {
            _border.addBorderShape(self.bounds, withCorner: 4.0, strokeColor: .black)
        }
    }
}
*/
