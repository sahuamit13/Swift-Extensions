import UIKit

extension NSMutableAttributedString {

    func addUnderlinedText(text: String,textColor:UIColor? = nil, underlineColor:UIColor = .black) {
        let size: CGFloat = 14
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: .regular), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: underlineColor]
        if let textColor = textColor {
            attributes[NSAttributedString.Key.foregroundColor] = textColor
        }
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        self.append(attributedString)
    }
    
    func append(text: String) {
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        self.append(attributedString)
    }
    
    func append(string: String, font: UIFont? = nil, color: UIColor? = nil) {
        var attributes = [NSAttributedString.Key: Any]()
        if let font = font {
            attributes[NSAttributedString.Key.font] = font
        }
        if let color = color {
            attributes[NSAttributedString.Key.foregroundColor] = color
        }
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        self.append(attributedString)
    }
    
}
