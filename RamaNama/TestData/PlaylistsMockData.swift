import Foundation

@MainActor
struct PlaylistsMock {
    static func data() -> PlaylistsModel {
        return makePlaylists(num: 15)
    }
    
    private static func makePlaylists(num: Int) -> PlaylistsModel {
        var items: [PlayListViewModelRow] = []
        let model = PlaylistsModel()
        (1...num).forEach { index in
            let playListRow = PlayListViewModelRow(
                id: "\(index)",
                title: "Title \(index)",
                imageURL: URL(string: "https://i.ytimg.com/vi/WzheSE7Py3g/default.jpg"),
                numberOfPlaylistItems: Int.random(in: 10...30),
                publishedDate: "2022-05-23T21:39:28Z",
                description: "Description \(index) this is a very long description that can spread across lines"
            )
            items.append(playListRow)
            model.playlistsViewModel.playlists.append(playListRow)
        }
        model.fetchStatus = .success
        return model
    }
}
