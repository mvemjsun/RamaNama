import SwiftUI

struct PlaylistsView: View {
    @ObservedObject var model: PlaylistsModel
    @State private var showingSettings = false
    @State var selectedLanguage: Language? = .english
    
    var filteredPlaylists: [PlayListViewModelRow] {
        model.viewModel.playlists.filter { playlist in
            guard let language = selectedLanguage, let title = playlist.title else {
                return false
            }
            return title.starts(with: language.rawValue)
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color.backgroundPrimary.edgesIgnoringSafeArea(.all)
                ScrollView {
                    ForEach(filteredPlaylists) { row in
                        NavigationLink {
                            PlaylistPageView(playlistPageId: row.id, description: row.description)
                        } label: {
                            PlaylistsRowView(rowData: row)
                        }
                    }
                    .navigationTitle("Playlists \(selectedLanguage?.rawValue ?? "")")
                }
                .padding()
                .toolbar {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $showingSettings) {
                        SettingsView(selectedLanguage: $selectedLanguage)
                    }
                }
                .navigationViewStyle(.automatic)
            }
            .preferredColorScheme(.dark)
            .ignoresSafeArea(.all, edges: [.bottom])
        }
        .onAppear {
            configureNavBarAppearance()
            Task {
                await model.fetch(pageToken: nil)
            }
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
