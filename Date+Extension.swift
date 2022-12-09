extension Date {
    var monthFullName: String {return Formatter.monthFullName.string(from: self)}
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var hour12: String { return Formatter.hour12.string(from: self) }
    var minute0x: String { return Formatter.minute0x.string(from: self) }
    var amPM: String { return Formatter.amPM.string(from: self) }
    var yearOfDate: String {return Formatter.yearOfDate.string(from: self) }
    var yearOfDateFull: String {return Formatter.yearOfDateFull.string(from: self) }
    
    func calculateAge() -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: self, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    func calculateAgeWithMonths() -> (Int, Int, Int) {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components([.year, .month, .day], from: self, to: now, options: [])
        let age = calcAge.year
        let month = calcAge.month
        let day = calcAge.day
        return (age!, month!, day!)
    }
    
    func yearSince() -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: self, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    var relativeTime: String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year) years ago"
        }
        
        if let year = components.year, year >= 1 {
            return "Last year"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month) months ago"
        }
        
        if let month = components.month, month >= 1 {
            return "Last month"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week) weeks ago"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "Last week"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day) days ago"
        }
        
        if let day = components.day, day >= 1 {
            return "Yesterday"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour) hours ago"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "An hour ago"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute) minutes ago"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "A minute ago"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        
        return "Just now"
        
    }
    
    func formattedDateString(dateFormat: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = dateFormat
        return formater.string(from: self)
    }
    
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        
        return end - start
    }
    
    func generateDatesToDate(endDate: Date) -> [Date] {
        var datesArray: [Date] =  [Date]()
        var startDate = self
        let calendar = Calendar.current
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        return datesArray
    }
    
    func getNextDates(forDays days: Int) -> [Date] {
        var datesArray: [Date] =  [Date]()
        var startDate = self
        let calendar = Calendar.current
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        for _ in 0..<days {
            datesArray.append(startDate)
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        return datesArray
    }
    
    func adding(months: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.month = months
        return calendar.date(byAdding: components, to: self)
    }
    
    func adding(days: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.day = days
        return calendar.date(byAdding: components, to: self)
    }
    
    func adding(months: Int, days: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.month = months
        components.day = days
        return calendar.date(byAdding: components, to: self)
    }
    
    func setMonth(month: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let set = Set<Calendar.Component>([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second])
        let daysInMonth = Date.daysInMonth(month: month)
        var components = calendar.dateComponents(set, from: self)
        if let day = components.day, day > daysInMonth {
            components.day = daysInMonth
        }
        components.month = month
        return calendar.date(from: components)
    }
    
    func setYear(year: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let set = Set<Calendar.Component>([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second])
        var components = calendar.dateComponents(set, from: self)
        if let month = components.month {
            let daysInMonth = Date.daysInMonth(month: month)
            if let day = components.day, day > daysInMonth {
                components.day = daysInMonth
            }
        }
        components.year = year
        return calendar.date(from: components)
    }
    
    func setDay(day: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let set = Set<Calendar.Component>([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second])
        var components = calendar.dateComponents(set, from: self)
        if let month = components.month {
            let daysInMonth = Date.daysInMonth(month: month)
            if day > daysInMonth {
                components.day = daysInMonth
            } else {
                components.day = day
            }
        }
        return calendar.date(from: components)
    }
    
    static func daysInMonth(month: Int) -> Int {
        let calendar = Calendar.current
        var dateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: month)
        dateComponents.day = 1
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    static func Parse(from dateString: String, dateFormat: String = "MM/dd/yyyy h:mm:ss a") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: dateString)
        return date
        
    }
    
    func stringValue(dateFormat: String = "MM/dd/yyyy h:mm:ss a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: self)
        return date
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var startOfMonth: Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)
        return  calendar.date(from: components)!
    }
    
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL"
        return formatter
    }()
    static let monthFullName: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
    static let yearOfDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy"
        return formatter
    }()
    static let yearOfDateFull: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
}
