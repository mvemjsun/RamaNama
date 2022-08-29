import SwiftUI

struct PlaylistsRowView: View {
    var rowData: PlayListViewModelRow
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(rowData.description)
                    .font(.headline)
                    .foregroundColor(.black)
                
                
                Text(DateUtil.toDateString(dateString: rowData.publishedDate) ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 3)
            }
            Spacer()
            VideoImageView(imageURL: rowData.imageURL, numberOfItems: rowData.numberOfPlaylistItems)
        }
        .frame(height: 95)
        .padding(.leading, 5)
        .padding(.trailing, 5)
    }
}

struct VideoImageView: View {
    var imageURL: URL?
    var numberOfItems: Int
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL)
                .frame(width: 120, height: 90)
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

struct Previews_PlaylistsRowView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
