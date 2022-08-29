import Foundation

struct DateUtil {
    static let formatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let formatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, YYYY"
        return formatter
    }()
    
    static func toDateString(dateString: String) -> String? {
        let date = formatter1.date(from: dateString)

        guard let date = date else { return nil }
        return formatter2.string(from: date)
    }
}
