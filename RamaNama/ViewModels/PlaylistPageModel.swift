import Foundation

@MainActor
final class PlaylistPageModel: ObservableObject {
    @Published var viewModel: [PlaylistPageRow] = []
    var fetchStatus: FetchStatus = .fetching

    private var networkService: NetworkServiceProvider
    private var nextPageToken: String?
    lazy private var ytService = YTService(networkService: networkService)
    
    init(networkService: NetworkServiceProvider = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch(playlistPage id: String, pageToken: String?) async {
        var data: Result<YTPlaylistPage, NetworkServiceError> = .failure(.couldNotParseNetworkResponse)
        
        do {
            data = try await ytService.fetchPlaylistPage(playlistPageId: id, pageToken: pageToken)
        } catch (let error) {
            print(error)
        }
        
        switch data {
        case .success(let playlistPage):
            let mappedData = mapToViewModel(playlistPage: playlistPage)
            mappedData.forEach { row in
                self.viewModel.append(row)
            }
            fetchStatus = .success

            guard playlistPage.nextPageToken != nil else { return }
            nextPageToken = playlistPage.nextPageToken
            await fetch(playlistPage: id, pageToken: nextPageToken)
            
        case .failure(let error):
            fetchStatus = FetchStatus.error(error)
        }
    }
    
    private func mapToViewModel(playlistPage: YTPlaylistPage) -> [PlaylistPageRow] {
        if playlistPage.hasMoreData() {
            nextPageToken = playlistPage.nextPageToken
        } else {
            nextPageToken = nil
        }
        
        return playlistPage.items.compactMap { (playlistItem) -> PlaylistPageRow? in
            guard let thumbnailURL = playlistItem.snippet.thumbnails.medium?.url,
                    let url = URL(string: thumbnailURL) else { return nil }
            return PlaylistPageRow(
                id: playlistItem.id,
                title: playlistItem.snippet.title,
                imageURL: url,
                videoId: playlistItem.snippet.resourceId.videoId
            )
        }
    }
}

struct PlaylistPageRow: Identifiable {
    let id: String
    let title: String
    let imageURL: URL?
    let videoId: String
}
