//
//  ContentView.swift
//  RamaNama
//
//  Created by Puneet Teng on 21/08/2022.
//

import SwiftUI

struct PlaylistsView: View {
    var playlists: PlaylistsViewModel
    @StateObject private var model: PlaylistsModel = PlaylistsModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(model.playlistsViewModel.playlists) { row in
                    NavigationLink {
                        PlaylistItemsView(playlistDescription: row.description)
                    } label: {
                        PlaylistsRowView(rowData: row)
                    }
                }
                .navigationTitle("Playlists")
            }
            .toolbar {
                Button {
                    
                } label: {
                    Label("Settings", systemImage: "gearshape.fill")
                        .foregroundColor(.blue)
                }
            }
         }
        .navigationViewStyle(.automatic)
        .task {
            await model.getData(pageToken: nil)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView(playlists: PlaylistsMock.data())
            .previewInterfaceOrientation(.portrait)
    }
}
