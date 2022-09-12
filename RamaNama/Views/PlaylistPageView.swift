import SwiftUI

struct PlaylistPageView: View {
    @StateObject var model: PlaylistPageModel = PlaylistPageModel()
    var playlistPageId: String
    var description: String
    
    var body: some View {
        ZStack {
            Color.backgroundPrimary.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: false) {
                Text(description)
                    .modifier(FontFactory.modifierFor(textType: .pageTitle))
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5))
                    .overlay( Divider()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                         .background(Color.gray), alignment: .bottom)
                Spacer()
                ForEach(model.viewModel) { row in
                    PlaylistPageRowView(title: row.title, videoId: row.videoId)
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 0))
                    
                }                
                .navigationTitle("Playlists Items")
            }
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
