import Foundation

struct YTPlaylistPage: Codable {
    let prevPageToken: String?
    let nextPageToken: String?
    let items: [YTPlaylistPageItem]
    let pageInfo: YTPlaylistPageInfo
    
    func hasMoreData() -> Bool {
        return nextPageToken != nil
    }
}

struct YTPlaylistPageItem: Codable {
    let id: String
    let snippet: YTPlaylistPageItemsSnippet
    let contentDetails: YTPlaylistPageContentDetails
}

struct YTPlaylistPageItemsSnippet: Codable {
    let publishedAt: String
    let title: String
    let description: String
    let thumbnails: YTThumbnail
    let position: Int
    let resourceId: YTPlaylistPageResourceId
}

struct YTPlaylistPageResourceId: Codable {
    let videoId: String
}

struct YTPlaylistPageContentDetails: Codable {
    let videoId: String
    let videoPublishedAt: String
}

struct YTPlaylistPageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
