//
//  ContentView.swift
//  RamaNama
//
//  Created by Puneet Teng on 21/08/2022.
//

import SwiftUI

struct PlaylistsView: View {
    @ObservedObject var model: PlaylistsModel
    @State private var showingSettings = false
    @State var selectedLanguage: Language? = .english
    
    var filteredPlaylists: [PlayListViewModelRow] {
        model.playlistsViewModel.playlists.filter { playlist in
            guard let language = selectedLanguage, let title = playlist.title else {
                return false
            }
            return title.starts(with: language.rawValue)
        }
    }
    
    var body: some View {
        
        switch model.fetchStatus {
        case .fetching:
            Text("Loading Playlists ...")
                .font(.headline)
                .frame(alignment: .center)
                .task {
                    await model.getData(pageToken: nil)
                }
        case .success:
            NavigationView {
                ScrollView {
                    ForEach(filteredPlaylists) { row in
                        NavigationLink {
                            PlaylistItemsView(playlistDescription: row.id ?? "N/A")
                        } label: {
                            PlaylistsRowView(rowData: row)
                        }
                        .padding()
                    }
                    .navigationTitle("Playlists \(selectedLanguage?.rawValue ?? "")")
                }
                .toolbar {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $showingSettings) {
                        SettingsView(selectedLanguage: $selectedLanguage)
                    }
                }
            }
            .navigationViewStyle(.automatic)
            
        case .error(_):
            Text("Error loading network data. Please check network & Retry")
                .multilineTextAlignment(.center)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView(model: PlaylistsMock.data(), selectedLanguage: .english)
            .previewInterfaceOrientation(.portrait)
    }
}
