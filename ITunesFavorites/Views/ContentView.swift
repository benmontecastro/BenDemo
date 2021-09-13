//
//  ContentView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    /// Shared across this view and its subviews
    @ObservedObject var favorites = Favorites()
    
    /// Private properties that causes view refresh
    @State var searchString: String = ""
    @State var tracks: [Track] = []
    @State var isFavoritesOnly = false

    let trackQuery = TrackQuery()
    func loadTracks() {
        self.tracks = trackQuery.tracksData
    }
    
    var body: some View {
        HeaderView()
        
        SearchBarView(searchText: $searchString)
            .padding(5)
        
        /// Navigation view controller
        NavigationView {
            /// Navigation Master Table view
            List(tracks.filter( { self.isFavoritesOnly ? $0.isFavorite() : searchString.isEmpty ? true : $0.trackName.contains(searchString) } ), id: \.trackId) {
                track in
                /// Navigation Detail view
                NavigationLink(destination: TrackDetailView(track: track)) {
                    TrackRowView(track: track)
                }
            }
            .navigationBarTitle("Tracks", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isFavoritesOnly = !self.isFavoritesOnly
                }) {
                    Image(systemName: "star.fill").imageScale(.medium)
                        .foregroundColor( self.isFavoritesOnly ? .green : .gray )
                        .border( self.isFavoritesOnly ? Color.green : Color.gray )
                }
            )
            .listStyle(PlainListStyle())
            .onAppear(perform: loadTracks)
        }
        .environmentObject(favorites)
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
