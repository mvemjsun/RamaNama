import SwiftUI

@main
struct RamaNamaApp: App {
    var body: some Scene {
        WindowGroup {
            PlaylistsView(playlists: PlaylistsMock.data())
        }
    }
}
