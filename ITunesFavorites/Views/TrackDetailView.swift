//
//  TrackDetailView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 13/9/21.
//

import SwiftUI

struct TrackDetailView: View {
    @ObservedObject var track: Track
    
    /// Shared within the app
    @EnvironmentObject var favorites: Favorites
    

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

struct TrackDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrackDetailView(track: TrackQuery().tracksData[0])
    }
}
