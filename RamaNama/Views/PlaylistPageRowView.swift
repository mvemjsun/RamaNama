import SwiftUI

struct PlaylistPageRowView: View {
    var title: String
    var videoId: String
    @State private var showPlayer = false

    var body: some View {
        HStack(spacing: 5) {
            Text(title)
                .font(.title2)
                .bold()
            Spacer()
            Button {
                showPlayer.toggle()
            } label: {
                Image(systemName: "play.circle")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $showPlayer) {
                PlayerView(videoId: videoId)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(height: 40)
    }
}

struct PlaylistPageRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistPageRowView(
            title: "Rama Nama hello how are you this is a long text",
            videoId: "1"
        )
            .previewInterfaceOrientation(.portrait)
    }
}
