import UIKit

public extension NSObject {
    
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    class func Parse(values: [String: Any])->Any {
        let newObject = self.init()
        newObject.parse(values: values)
        return newObject
    }
    
    func parse(values: [String: Any]) {
        let pNames = propertyNames()
        for pName in pNames {
            if let value = values[pName] {
                if value is [String: Any] {
                    self.setValue(value, forKey: pName)
                }
            }
        }
    }
    
    func propertyNames() -> Array<String> {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var deviceIdiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    class var deviceIdiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
}
