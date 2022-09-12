import SwiftUI

struct PlaylistPageRowView: View {
    var title: String
    var videoId: String
    var delegate: PlayerDelegate
    @State private var showPlayer = false

    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .modifier(FontFactory.modifierFor(textType: .rowText))
            Spacer()
            Button {
                showPlayer.toggle()
            } label: {
                Image(systemName: "play.circle")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $showPlayer) {
                PlayerView(videoId: videoId, delegate: delegate)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
        .overlay( Divider()
            .frame(maxWidth: .infinity, maxHeight: 0.5)
             .background(Color.gray), alignment: .bottom)
        .frame(height: 50)
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
