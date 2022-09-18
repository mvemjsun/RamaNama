import SwiftUI

struct PlaylistsView: View {
    @ObservedObject var model: PlaylistsModel
    @State private var showingSettings = false
    @State var selectedLanguage: Language = .english
    @State var selectedBook: Book = .balaKanda
    @State var book: Book = .balaKanda
    
    var filteredPlaylists: [PlayListViewModelRow] {
        model.viewModel.playlists.filter { playlist in
            guard let title = playlist.title else {
                return false
            }
            return title.hasPrefix("\(selectedLanguage.rawValue)") && title.contains(selectedBook.rawValue)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundPrimary.edgesIgnoringSafeArea(.all)
                List {
                    ForEach(filteredPlaylists) { row in
                        NavigationLink {
                            PlaylistPageView(playlistPageId: row.id, description: row.description, title: "\(row.book) \(row.chapter)")
                        } label: {
                            PlaylistsRowView(rowData: row)
                        }
                    }
                    .navigationTitle("Ramayana")
                }
                .toolbar {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showingSettings) {
                        SettingsView(selectedLanguage: $selectedLanguage, selectedBook: $selectedBook)
                    }
                }
                .navigationViewStyle(.automatic)
            }
            .preferredColorScheme(.dark)
            .ignoresSafeArea(.all, edges: [.bottom])
        }
    }
    
    private func configureNavBarAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

struct ContentView_Previews: PreviewProvider {
    static let data = PlaylistsMock.data()
    static var previews: some View {
        PlaylistsView(model: data)
            .previewInterfaceOrientation(.portrait)
    }
}
