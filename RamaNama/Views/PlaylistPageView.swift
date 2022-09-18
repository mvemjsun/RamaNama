import SwiftUI

struct PlaylistPageView: View {
    @StateObject var model: PlaylistPageModel = PlaylistPageModel()
    var playlistPageId: String
    var description: String
    var title: String
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary.edgesIgnoringSafeArea(.all)
            List {
                Text(description)
                    .font(.title2)
                Spacer()
                ForEach(model.viewModel) { row in
                    PlaylistPageRowView(title: row.title, videoId: row.videoId)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
                    
                }                
                .navigationTitle(title)
            }
            .foregroundColor(.orange)
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
