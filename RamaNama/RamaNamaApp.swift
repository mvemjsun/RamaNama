import SwiftUI

@main
struct RamaNamaApp: App {
    var body: some Scene {
        WindowGroup {
            PlaylistsView(model: PlaylistsModel(), selectedLanguage: .english)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
