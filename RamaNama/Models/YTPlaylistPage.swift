import Foundation

struct YTPlaylistPage: Codable {
    let prevPageToken: String?
    let nextPageToken: String?
    let items: [YTPlaylistItem]
    let pageInfo: YTPlaylistItemsPageInfo
}

struct YTPlaylistItemsSnippet: Codable {
    let publishedAt: String
    let title: String
    let description: String
    let thumbnails: YTThumbnail
    let position: Int
    let resourceId: YTPlaylistItemsResourceId
}

struct YTPlaylistItemsResourceId: Codable {
    let videoId: String
}

struct YTPlaylistItemsContentDetails: Codable {
    let videoId: String
    let videoPublishedAt: String
}

struct YTPlaylistItemsPageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
