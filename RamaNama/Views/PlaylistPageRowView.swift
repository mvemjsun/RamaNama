import SwiftUI

struct PlaylistPageRowView: View {
    var title: String
    var videoId: String
    var delegate: PlayerDelegate
    @State private var showPlayer = false

    var body: some View {
        HStack {
            Text(title)
                .modifier(FontFactory.modifierFor(textType: .rowText))
            Spacer()
//            Image(systemName: "play.circle")
//                .aspectRatio(contentMode: .fit)
//                .foregroundColor(.black)
            Button("Play") {
                showPlayer.toggle()
            }
            .sheet(isPresented: $showPlayer) {
                PlayerView(videoId: videoId, delegate: delegate)
            }
        }
        .frame(height: 90)
        
    }
}

struct PlaylistPageRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistPageRowView(
            title: "Rama Nama hello how are you this is a long text",
            videoId: "1",
            delegate: PlayerDelegate()
        )
            .previewInterfaceOrientation(.portrait)
    }
}
