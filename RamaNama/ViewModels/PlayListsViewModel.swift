import Foundation
struct PlaylistsViewModel {
    var playlists: [PlayListViewModelRow]
}

struct PlayListViewModelRow: Identifiable {
    let id: String
    let title: String?
    let imageURL: URL?
    let numberOfPlaylistItems: Int
    let publishedDate: String
    let description: String
}

@MainActor
final class PlaylistsModel: ObservableObject {
    @Published var playlistsViewModel: PlaylistsViewModel
    var fetchStatus: FetchStatus = .fetching
    
    private var playlistsModel: YTPlaylists?
    private var networkService: NetworkServiceProvider
    private var nextPageToken: String?
    lazy private var ytService = YTService(networkService: networkService)
    
    init(networkService: NetworkServiceProvider = NetworkService()) {
        self.networkService = networkService
        playlistsViewModel = PlaylistsViewModel(playlists: [])
    }
    
    func getData(pageToken: String?) async {
        var data: Result<YTPlaylists, NetworkServiceError> = .failure(.couldNotParseNetworkResponse)
        do {
            data = try await ytService.fetchPlaylists(pageToken: pageToken)
        } catch {}
        
        switch data {
        case .success(let playlists):
            let viewModel = mapToViewModel(playlists: playlists)
            viewModel.forEach { row in
                self.playlistsViewModel.playlists.append(row)
            }
            guard playlists.nextPageToken != nil else { return }
            nextPageToken = playlists.nextPageToken
            await getData(pageToken: nextPageToken)
             fetchStatus = .success
            
        case .failure(let error):
            fetchStatus = FetchStatus.error(error)
        }
        
    }
    
    func mapToViewModel(playlists: YTPlaylists) -> [PlayListViewModelRow] {
        if playlists.hasMoreData() {
            nextPageToken = playlists.nextPageToken
        } else {
            nextPageToken = nil
        }
        return playlists.items.compactMap { (playlistItem) -> PlayListViewModelRow? in
            if let urlString = playlistItem.snippet.thumbnails?.defaultImage?.url, let url = URL(string: urlString) {
                return PlayListViewModelRow(
                    id: playlistItem.id,
                    title: playlistItem.snippet.title,
                    imageURL: url,
                    numberOfPlaylistItems: playlistItem.contentDetails.itemCount,
                    publishedDate: playlistItem.snippet.publishedAt,
                    description: playlistItem.snippet.description
                )
            } else {
                return nil
            }
        }
    }
}
