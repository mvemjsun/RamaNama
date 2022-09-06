import Foundation

protocol YTServiceProvider {
    func fetchPlaylists(pageToken: String?) async throws -> Result<YTPlaylists, NetworkServiceError>

    func fetchPlaylistPage(
        networkService: NetworkServiceProvider,
        playlistPageId: String,
        pageToken: String?
    ) async throws -> Result<YTPlaylistPage, NetworkServiceError>

    // func fetchVideo(networkService: NetworkServiceProvider) async throws
}

struct YTService: YTServiceProvider {
    let networkService: NetworkServiceProvider

    init(networkService: NetworkServiceProvider = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchPlaylists(pageToken: String?) async throws -> Result<YTPlaylists, NetworkServiceError> {
        
        let components = Headers.buildYTURLComponentsForPlayLists(pageToken: pageToken)
        
        guard let url = components.url else {
            return .failure(.invalidServiceConfiguration)
        }
        
        return try await self.networkService.fetch(url: url, usingHeaders: nil)
    }
}

extension YTService {
    func fetchPlaylistPage(
        networkService: NetworkServiceProvider = NetworkService(),
        playlistPageId id: String,
        pageToken: String?
    ) async throws -> Result<YTPlaylistPage, NetworkServiceError> {
        let components = Headers.buildYTURLComponentsForPlayListPage(playlistId: id, pageToken: pageToken)
        
        guard let url = components.url else {
            return .failure(.invalidServiceConfiguration)
        }
        
        return try await self.networkService.fetch(url: url, usingHeaders: nil)
    }
}
