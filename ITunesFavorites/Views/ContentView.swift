//
//  ContentView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    @State var searchString: String = ""
    @State var tracks: [Track] = []
    @State var isFavoritesOnly = false

    let trackQuery = TrackQuery()
    func loadTracks() {
        self.tracks = trackQuery.tracksData
    }
    
    var body: some View {
        SearchBarView(searchText: $searchString)
            .padding(5)
        
        NavigationView {
            List(tracks.filter( { self.isFavoritesOnly ? $0.isFavorite() : searchString.isEmpty ? true : $0.trackName.contains(searchString) } ), id: \.trackId) {
                track in
                NavigationLink(destination: DetailView(track: track)) {
                    HStack {
                        track.image
                            .frame(width: 30, height: 30)
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
                                Text("\(track.currency)\(track.price, specifier: "%0.2f")")
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

struct DetailView: View {
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
