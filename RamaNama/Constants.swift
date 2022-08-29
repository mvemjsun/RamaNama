enum Constants {
    struct YT {
        static let channelId = "UCDzphCGGssXKaZewOWmz5rA"
        static let key = "AIzaSyAjvS2YTUN9IvcYONrQsSGr6eajVsk4oQo"
        static let part = "contentDetails,snippet"
        static let maxResults = "50"
        struct URLS {
            static let root = "www.googleapis.com"
            static let rootPath = "/youtube/v3"
            static let playlistsPath = "/playlists"
            static let playlistItemsPath = "/playlistItems"
            static let videosPath = "/videos"
        }
        
        enum Header: String {
            case key
            case channelId
            case maxResults
            case part
            case playlistId
            case pageToken
        }
    }
}
