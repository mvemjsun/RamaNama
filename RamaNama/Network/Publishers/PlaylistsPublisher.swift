import Combine
import Foundation

protocol PlaylistsPublishing {
    var playlistPublisher: AnyPublisher<YTPlaylists, NetworkServiceError> { get }
    
    func fetchPlaylists(pageToken: String?) async throws
}

class PlaylistsPublisher: PlaylistsPublishing {
    private(set) var playlistPublisher: AnyPublisher<YTPlaylists, NetworkServiceError>
    private var subject = PassthroughSubject<YTPlaylists, NetworkServiceError>()

    private var networkService: NetworkServiceProvider
    lazy private var ytService = YTService(networkService: networkService)
    private var pageToken: String?
    var cancellableTimer: AnyCancellable?
    
    init(networkService: NetworkServiceProvider = NetworkService()) {
        playlistPublisher = subject.eraseToAnyPublisher()
        self.networkService = networkService
    }
    
    func fetchPlaylists(pageToken: String?) async throws {
        let result = try await ytService.fetchPlaylists(pageToken: pageToken)
        
        switch result {
        case .success(let data):
            subject.send(data)
        case .failure(let error):
            subject.send(completion: .failure(error))
        }
    }
}
