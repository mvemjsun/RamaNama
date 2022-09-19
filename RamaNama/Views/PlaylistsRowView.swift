import SwiftUI

struct PlaylistsRowView: View {
    var rowData: PlayListViewModelRow
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Text(rowData.book)
                    .font(.title2)
                    .bold()
                Text(rowData.chapter)
                    .font(.title3)
                    .bold()
                Text(rowData.language)
                    .font(.caption)
                    .bold()
                Text(DateUtil.toDateString(dateString: rowData.publishedDate) ?? "")
                    .font(.caption)
                    .foregroundColor(.white)
                    .bold()
                    
            }
            .foregroundColor(.orange)
            Spacer()
            VideoImageView(imageURL: rowData.imageURL, numberOfItems: rowData.numberOfPlaylistItems)
        }
        .frame(height: 90)
    }
}

struct VideoImageView: View {
    var imageURL: URL?
    var numberOfItems: Int
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL)
                .frame(width: 120.0, height: 90)
                .clipped()
                .aspectRatio(contentMode: .fit)
            Badge(numberOfItems: numberOfItems)
                .offset(x: 40, y: 25)
        }
    }
}

struct Badge: View {
    let numberOfItems: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30.0, height: 30.0)
                .foregroundColor(.blue)
            Text("\(numberOfItems)")
                .font(.callout)
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct PlaylistsRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsRowView(rowData:
                            PlayListViewModelRow(
                                id: "1",
                                title: "Row 1",
                                imageURL: URL(string: "https://i.ytimg.com/vi/NvVbxlTETGk/mqdefault.jpg"),
                                numberOfPlaylistItems: 10,
                                publishedDate: "2022-04-03T22:33:48Z",
                                description: "Description that is quite long and can spread across multiple lines of text",
                                language: "",
                                book: "",
                                chapter: ""
                            )
        )
    }
}
