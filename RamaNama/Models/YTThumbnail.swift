import Foundation

struct YTThumbnail: Codable {
    let defaultImage: YTThumbnailItem?
    let medium: YTThumbnailItem?
    let high: YTThumbnailItem?
    let standard: YTThumbnailItem?
    let maxres: YTThumbnailItem?
    
    private enum CodingKeys: String, CodingKey {
        typealias RawValue = String
        case defaultImage = "default"
        case medium
        case high
        case standard
        case maxres
    }
}

struct YTThumbnailItem: Codable {
    let url: String
    let width: Int
    let height: Int
}
