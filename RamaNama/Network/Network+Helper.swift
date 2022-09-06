import Foundation

struct Headers {
    // MARK: Playlists
    static func buildYTURLComponentsForPlayLists(pageToken: String?) -> URLComponents {
        var components = buildYTURLComponents()
        components.path = Constants.YT.URLS.rootPath + Constants.YT.URLS.playlistsPath
        if let pageToken = pageToken {
            components.queryItems?.append(URLQueryItem(name: Constants.YT.Header.pageToken.rawValue, value: pageToken))
        }
        return components
    }
    
    // MARK: Playlist Items
    static func buildYTURLComponentsForPlayListPage(playlistId: String, pageToken: String?) -> URLComponents {
        var components = buildYTURLComponents()
        components.path = Constants.YT.URLS.rootPath + Constants.YT.URLS.playlistItemsPath
        components.queryItems?.append(URLQueryItem(name: Constants.YT.Header.playlistId.rawValue, value: playlistId))
        if let pageToken = pageToken {
            components.queryItems?.append(URLQueryItem(name: Constants.YT.Header.pageToken.rawValue, value: pageToken))
        }
        return components
    }
    
    private static func buildYTURLComponents() -> URLComponents {
        
        var urlComponents = URLComponents()
        
        let queryItems = [
            URLQueryItem(name: Constants.YT.Header.key.rawValue, value: Constants.YT.key),
            URLQueryItem(name: Constants.YT.Header.channelId.rawValue, value: Constants.YT.channelId),
            URLQueryItem(name: Constants.YT.Header.maxResults.rawValue, value: Constants.YT.maxResults),
            URLQueryItem(name: Constants.YT.Header.part.rawValue, value: Constants.YT.part)
        ]
        
        urlComponents.scheme = "https"
        urlComponents.host = Constants.YT.URLS.root
        urlComponents.queryItems = queryItems
        return urlComponents
    }
}
