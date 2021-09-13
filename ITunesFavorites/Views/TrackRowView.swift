//
//  TrackRowView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 13/9/21.
//

import SwiftUI

struct TrackRowView: View {
    /// Shared within the app
    @EnvironmentObject var favorites: Favorites

    let track: Track
    var body: some View {
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

struct TrackRowView_Previews: PreviewProvider {
    static var previews: some View {
        TrackRowView(track: TrackQuery().tracksData[0])
    }
}
