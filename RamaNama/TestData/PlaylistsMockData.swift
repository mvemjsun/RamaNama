import Foundation

struct PlaylistsMock {
    static func data() -> PlaylistsViewModel {
        return makePlaylists(num: 20)
    }
    
    private static func makePlaylists(num: Int) -> PlaylistsViewModel {
        var items: [PlayListViewModelRow] = []
        
        (1...num).forEach { index in
            let playListRow = PlayListViewModelRow(
                id: "\(index)",
                title: "Title \(index)",
                imageURL: URL(string: "https://i.ytimg.com/vi/WzheSE7Py3g/default.jpg"),
                numberOfPlaylistItems: Int.random(in: 10...30),
                publishedDate: "2022-05-23T21:39:28Z",
                description: "Description \(index)"
            )
            items.append(playListRow)
        }        
        return PlaylistsViewModel(playlists: items)
    }
}
