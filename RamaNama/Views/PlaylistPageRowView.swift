import SwiftUI

struct PlaylistPageRowView: View {
    var title: String
    var videoId: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                 .font(.subheadline)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: "play.circle")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
        }
        .frame(height: 40)
    }
}

struct PlaylistPageRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistPageRowView(title: "Rama Nama hello how are you this is a long text", videoId: "1")
            .previewInterfaceOrientation(.portrait)
    }
}
