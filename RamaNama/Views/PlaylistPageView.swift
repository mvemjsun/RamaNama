import SwiftUI

struct PlaylistPageView: View {
    @StateObject var model: PlaylistPageModel = PlaylistPageModel()
    var playlistPageId: String
    
    var body: some View {
        ScrollView {
            ForEach(model.viewModel) { row in
                NavigationLink {
                    Text("Video")
                } label: {
                    PlaylistsPageRowView(playlistPageRow: row)
                }
                .padding()
            }
            .navigationTitle("Playlists Items")
        }
        .onAppear {
            Task {
                await model.fetch(playlistPage: playlistPageId, pageToken: nil)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct PlaylistsPageRowView: View {
    var playlistPageRow: PlaylistPageRow
    
    var body: some View {
        HStack {
            Text(playlistPageRow.title)
                .frame(height: 20, alignment: .leading)
                .font(.headline)
            Spacer()
        }
    }
}
