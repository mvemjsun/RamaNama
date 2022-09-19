import Foundation

@MainActor
struct PlaylistsMock {
    static func data() -> PlaylistsModel {
        return makePlaylists(num: 30)
    }
    
    private static func makePlaylists(num: Int) -> PlaylistsModel {
        var items: [PlayListViewModelRow] = []
        let model = PlaylistsModel()
        (1...num).forEach { index in
            let language = ["English", "Hindi", "Telugu", "Sanskrit"].randomElement() ?? "English"
            let book = ["Bala Kanda", "Sundar Kanda", "Aranya Kanda", "Ayodhya Kanda", "Kishkindha Kanda", "Yuudha Kanda", "Uttara Kanda"].randomElement() ?? "Bala Kanda"
            let chapter = [1,2,3,4,5,6,7,8,9].randomElement() ?? 1
            print("--> \(language)")
            let playListRow = PlayListViewModelRow(
                id: "\(index)",
                title: "APP/\(language)/\(book)/Chapter \(chapter)",
                imageURL: URL(string: "https://i.ytimg.com/vi/WzheSE7Py3g/default.jpg"),
                numberOfPlaylistItems: Int.random(in: 10...30),
                publishedDate: "2022-05-23T21:39:28Z",
                description: "\(language) Description \(index) this is a very long description that can spread across lines",
                language: language,
                book: book,
                chapter: "Chapter \(chapter)"
            )
            items.append(playListRow)
            model.viewModel.playlists.append(playListRow)
        }
        model.fetchStatus = .success
        return model
    }
}
