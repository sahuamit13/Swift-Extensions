extension Data {
    
    var htmlToAttributedString: NSAttributedString? {
        if !self.isEmpty {
            return try? NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        return nil
    }
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
    
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
