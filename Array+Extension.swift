
/**
Get Unique Elements from Array
*/
extension Array where Element: Equatable {
    
    public func uniq() -> [Element] {
        var arrayCopy = self
        arrayCopy.uniqInPlace()
        return arrayCopy
    }
    
    mutating public func uniqInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }
}
extension Array {
    func unique<T: Hashable>(map: ((Element) -> (T))) -> [Element] {
        /**
        the unique list kept in a Set for fast retrieval
        */
        var set = Set<T>() 
        /**
        keeping the unique list of elements but ordered
        */
        var arrayOrdered = [Element]() 
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
