import SwiftUI

struct PlaylistPageView: View {
    @StateObject var model: PlaylistPageModel = PlaylistPageModel()
    var playlistPageId: String
    var description: String
    var delegate: PlayerDelegate = PlayerDelegate()
    
    var body: some View {
        ScrollView {
            Text(description)
                .font(.headline)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
            Spacer()
            ForEach(model.viewModel) { row in
                NavigationLink {
                    Text("Video")
                } label: {
                    PlaylistPageRowView(title: row.title, videoId: row.videoId, delegate: delegate)
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
