//
//  ContentView.swift
//  RamaNama
//
//  Created by Puneet Teng on 21/08/2022.
//

import SwiftUI

struct PlaylistsView: View {
    @ObservedObject var model: PlaylistsModel = PlaylistsModel()
    @State private var showingSettings = false
    @State var selectedLanguage: Language? = .english
    
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
                    ForEach(model.playlistsViewModel.playlists) { row in
                        NavigationLink {
                            PlaylistItemsView(playlistDescription: row.id)
                        } label: {
                            PlaylistsRowView(rowData: row)
                        }
                        .padding()
                    }
                    .navigationTitle("Playlists (\(selectedLanguage?.rawValue ?? ""))")
                }
                .toolbar {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape.fill")
                            .foregroundColor(.blue)
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
        PlaylistsView(model: PlaylistsMock.data())
            .previewInterfaceOrientation(.portrait)
    }
}
