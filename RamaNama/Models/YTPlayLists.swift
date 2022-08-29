import Foundation

struct YTPlaylists: Codable {
    let items: [YTPlaylistItem]
    let nextPageToken: String?
    let prevPageToken: String?
    let pageInfo: YTPlaylistsPageInfo
    
    func hasMoreData() -> Bool {
        return nextPageToken != nil
    }
}

struct YTPlaylistItem: Codable {
    var id: String
    var snippet: YTPlaylistSnippet
    var contentDetails: YTPlaylistContentDetails
}

struct YTPlaylistSnippet: Codable {
    var publishedAt: String
    var title: String
    var description: String
    var thumbnails: YTThumbnail?
}

struct YTPlaylistContentDetails: Codable {
    let itemCount: Int
}

struct YTPlaylistsPageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
