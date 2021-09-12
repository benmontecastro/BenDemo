//
//  ContentView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    @State var tracks: [Track] = []
    
    let trackQuery = TrackQuery()
    func loadTracks() {
        self.tracks = trackQuery.tracksData
    }
    
    var body: some View {
        NavigationView {
            List(tracks, id: \.trackId) {
                track in
                NavigationLink(destination: DetailView(track: track)) {
                    HStack {
                        track.image
                            .frame(width: 30, height: 30)
                        VStack {
                            HStack {
                                Text("\(track.trackName)")
                                Spacer()
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
            .navigationBarTitle("Tracks")
            .onAppear(perform: loadTracks)
        }
        
    }
}

struct DetailView: View {
  let track: Track
  var body: some View {
    VStack {
        Text(track.description)
            .multilineTextAlignment(.leading)
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
