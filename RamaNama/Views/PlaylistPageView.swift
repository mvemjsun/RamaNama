import SwiftUI
import YouTubeiOSPlayerHelper

struct PlaylistPageView: View {
    @StateObject var model: PlaylistPageModel = PlaylistPageModel()
    var playlistPageId: String
    var description: String
    var title: String
    @State private var delegate = PlayerViewDelegate()
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary.edgesIgnoringSafeArea(.all)
            List {
                Text(description)
                    .font(.title2)
                    .foregroundColor(.white)

                ForEach(model.viewModel) { row in
                    PlaylistPageRowView(title: row.title, videoId: row.videoId, delegate: delegate)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
                    
                }
                .listRowBackground(Color("theme"))
                .navigationTitle(title)
            }
            .foregroundColor(.white)
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        .onAppear {
            Task {
                await model.fetch(playlistPage: playlistPageId, pageToken: nil)
            }
        }
        .navigationViewStyle(.stack)
    }
}
