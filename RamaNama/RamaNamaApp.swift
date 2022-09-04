import SwiftUI

@main
struct RamaNamaApp: App {
    var body: some Scene {
        WindowGroup {
            PlaylistsView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
