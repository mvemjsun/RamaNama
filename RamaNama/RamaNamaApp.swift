import SwiftUI

@main
struct RamaNamaApp: App {
    @State var playlistModel = PlaylistsModel()

    var body: some Scene {
        WindowGroup {
            PlaylistsView(model: playlistModel, selectedLanguage: .english)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .task {
                    await fetchPlaylist()
                }
        }
    }
    
    @MainActor
    func fetchPlaylist() async {
        await playlistModel.fetch(pageToken: nil)
    }
}
