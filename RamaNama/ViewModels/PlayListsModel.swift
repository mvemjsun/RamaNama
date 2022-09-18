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
    let language: String
    let book: String
    let chapter: String
}

final class PlaylistsModel: ObservableObject {
    @Published var viewModel: PlaylistsViewModel
    var fetchStatus: FetchStatus = .fetching
    
    private var networkService: NetworkServiceProvider
    private var nextPageToken: String?
    lazy private var ytService = YTService(networkService: networkService)
    
    init(networkService: NetworkServiceProvider = NetworkService()) {
        self.networkService = networkService
        viewModel = PlaylistsViewModel(playlists: [])
    }
    
    @MainActor
    func fetch(pageToken: String?) async {
        var data: Result<YTPlaylists, NetworkServiceError> = .failure(.couldNotParseNetworkResponse)
        do {
            data = try await ytService.fetchPlaylists(pageToken: pageToken)
        } catch {}
        
        switch data {
        case .success(let playlists):
            fetchStatus = .success
            let viewModel = mapToViewModel(playlists: playlists)
            viewModel.forEach { row in
                self.viewModel.playlists.append(row)
            }

            guard playlists.nextPageToken != nil else { return }
            nextPageToken = playlists.nextPageToken
            await fetch(pageToken: nextPageToken)

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
            guard playlistItem.snippet.title.hasPrefix("APP/"),
                    playlistItem.contentDetails.itemCount > 0 else { return nil }
            if let urlString = playlistItem.snippet.thumbnails?.defaultImage?.url, let url = URL(string: urlString) {
                let titleTextTuple = titleText(titleText: playlistItem.snippet.title)
                return PlayListViewModelRow(
                    id: playlistItem.id,
                    title: titleTextTuple.0,
                    imageURL: url,
                    numberOfPlaylistItems: playlistItem.contentDetails.itemCount,
                    publishedDate: playlistItem.snippet.publishedAt,
                    description: playlistItem.snippet.description,
                    language: titleTextTuple.1,
                    book: titleTextTuple.2,
                    chapter: titleTextTuple.3
                )
            } else {
                return nil
            }
        }
    }
    
    func titleText(titleText: String) -> (String, String, String, String) {
        let titleParts = titleText.split(separator: "/")
        let language = titleParts[1]
        let book = titleParts[2]
        let chapter = titleParts[3]
        let title = "\(language) \(book) \(chapter)"
        return ("\(title)", "\(language)", "\(book)", "\(chapter)")
    }
}
