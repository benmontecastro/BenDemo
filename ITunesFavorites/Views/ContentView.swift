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
            /// Navigation Master Table view - TODO: extract as SwiftUI view
            List(tracks.filter( { self.isFavoritesOnly ? $0.isFavorite() : searchString.isEmpty ? true : $0.trackName.contains(searchString) } ), id: \.trackId) {
                track in
                /// Navigation Detail view - TODO: extract as SwiftUI view
                NavigationLink(destination: DetailView(track: track)) {
                    HStack {
                        TrackImageView(urlString: track.imageUrl.absoluteString)

                        VStack {
                            HStack {
                                Text("\(track.trackName)")

                                Spacer()
                                
                                if self.favorites.contains(track) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.green)
                                }
                            }
                            HStack {
                                Text("\(track.genre)")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                Text("\(track.currency) \(track.price, specifier: "%0.2f")")
                                    .font(.subheadline)
                            }
                        }
                    }
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

/// Navigation Detail view - TODO: separate as SwiftUI view
struct DetailView: View {
    /// Shared within the app
    @EnvironmentObject var favorites: Favorites
    
    let track: Track
    var body: some View {
        VStack {
            Text("\(track.trackName)")
                .font(.headline)
                .padding()
            
            Text(track.description)
                .multilineTextAlignment(.leading)
                .padding()
            
            Button(favorites.contains(track) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(track) {
                    self.favorites.remove(track)
                } else {
                    self.favorites.add(track)
                }
            }
                .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
