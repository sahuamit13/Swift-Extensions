import UIKit

eextension NSAttributedString {
    /**
     calculate height of the attrirbuted string
     */
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    /**
     calculate width of the attrirbuted string
     */
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }
        
        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitBold)!
                }
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitItalic)!
                }

                attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }
        
        self.init(attributedString: attr)
    }
    /**
     search any specific sting to a colored attrirbuted search string
     */
    func searchAttributedString(_ stringToColor: String, color: UIColor = UIColor.blue) -> NSAttributedString {
        let range = (self.string.lowercased() as NSString).range(of: stringToColor.lowercased())
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributedString
    }
    /**
     search any specific sting to a colored attrirbuted search string and also you can change the font size to
     */
    func searchAttributedStringChangeFont(_ stringToColor: String, color: UIColor = UIColor.blue, font: UIFont = UIFont.systemFont(ofSize: 12)) -> NSAttributedString {
        let range = (self.string as NSString).range(of: stringToColor)
        let attributedString = NSMutableAttributedString(attributedString: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return attributedString
    }
    /**
     search diffrent words to a colored attrirbuted search string
     E.g. "Hello World"
     */
    func searchAttributedStringByWord(_ stringToColor: String, color: UIColor = UIColor.blue) -> NSAttributedString {
        let words = stringToColor.words()
        let attributedString = NSMutableAttributedString(attributedString: self)
        for word in words {
            let range = (self.string.lowercased() as NSString).range(of: word.lowercased())
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return attributedString
    }
    /**
     convert Attributed String to HTML string
     */
    func convertToHTMLString() -> String {
        do {
            let htmlData = try self.data(from: NSRange(location: 0, length: self.length), documentAttributes: [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html])
            if let htmlString = String(data: htmlData, encoding: String.Encoding.utf8) {
                return htmlString
            }
        } catch {
            return ""
        }
        return ""
    }
}

/**
added string extions if you want search sting by words
*/
extension String {
    func words() -> [String] {
        
        guard let range = self.range(of: self) else { return [] }
        var words = [String]()
        
        self.enumerateSubstrings(in: range, options: NSString.EnumerationOptions.byWords) { (substring, _, _, _) -> Void in
            if let substring = substring {
                words.append(substring)
            }
        }
        
        return words
    }
}
