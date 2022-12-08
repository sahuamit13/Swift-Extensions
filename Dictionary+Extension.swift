// Any Dictionary/Nested Dictionary
// if you want to update any specific key Value you can update it
extension Dictionary
{
    mutating func updateKeyValueRecursively(key: Key, newValue: Value) -> Bool
    {
        if keys.contains(key)
        {
            self[key] = newValue
            return true
        }
        for (_, value) in enumerated()
        {
            if var dict = value.value as? Dictionary<Key, Value> {
                if dict.updateKeyValueRecursively(key: value.key, newValue: newValue), let newDict = dict as? Value {
                    self[value.key] = newDict
                    return true
                }
            }
        }
        return false
    }
}
