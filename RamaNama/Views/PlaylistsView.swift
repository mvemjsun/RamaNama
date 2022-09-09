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
            ScrollView {
                ForEach(filteredPlaylists) { row in
                    NavigationLink {
                        PlaylistPageView(playlistPageId: row.id, description: row.description)
                    } label: {
                        PlaylistsRowView(rowData: row)
                    }
                    .padding()
                }
                .navigationTitle("Playlists \(selectedLanguage?.rawValue ?? "")")
            }
            .toolbar {
                Button {
                    showingSettings.toggle()
                } label: {
                    Label("Settings", systemImage: "gearshape.fill")
                        .foregroundColor(.black)
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView(selectedLanguage: $selectedLanguage)
                }
            }
        }
        .onAppear {
            Task {
                await model.fetch(pageToken: nil)
            }
        }
        .navigationViewStyle(.automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let data = PlaylistsMock.data()
    static var previews: some View {
        PlaylistsView(model: data, selectedLanguage: .english)
            .previewInterfaceOrientation(.portrait)
    }
}
