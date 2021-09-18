//
//  ContentView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    /// Shared across this view and its subviews
    @ObservedObject var viewModel: TrackQuery
    @ObservedObject var favorites = Favorites()
    
    // Used for detecting when this scene is backgrounded and isn't currently visible.
    @Environment(\.scenePhase) private var scenePhase

    /// Private properties that causes view refresh
    @State var searchString: String = ""
    @State var isFavoritesOnly = false
    
    @SceneStorage("trackId") private var trackId: String?
    
    init(viewModel: TrackQuery) {
        self.viewModel = viewModel
        self.searchString = viewModel.searchString
    }
    
    /// Handles view variables when view becomes active
    func loadData() {
        self.searchString = viewModel.searchString
        self.isFavoritesOnly = viewModel.isFavoritesOnly
    }
    
    var body: some View {
        HeaderView()
        
        SearchBarView(searchText: $viewModel.searchString)
            .padding(5)
            .onChange(of: viewModel.searchString, perform: { value in
                self.searchString = value
            })
        
        /// Navigation view controller
        NavigationView {
            /// Navigation Master Table view
            List(viewModel.tracksData.filter( { viewModel.isFavoritesOnly ? $0.isFavorite() : viewModel.searchString.isEmpty ? true : $0.trackName.contains(viewModel.searchString) } ), id: \.trackId) {
                track in
                /// Navigation Detail view
                NavigationLink(destination: TrackDetailView(track: track)) {
                    TrackRowView(track: track)
                }
            }
            .navigationBarTitle("Tracks", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    viewModel.isFavoritesOnly = !viewModel.isFavoritesOnly
                    self.isFavoritesOnly = viewModel.isFavoritesOnly
                }) {
                    Image(systemName: "star.fill").imageScale(.medium)
                        .foregroundColor( viewModel.isFavoritesOnly ? .green : .gray )
                        .border( self.isFavoritesOnly ? Color.green : Color.gray )
                }
            )
            .listStyle(PlainListStyle())
            .onAppear(perform: loadData)
            .onChange(of: viewModel.searchString, perform: { value in
                UserRepository().saveSearchText(text: value)
            })
            .onChange(of: isFavoritesOnly, perform: { value in
                UserRepository().saveShowFavorites(show: value)
            })
        }
        .environmentObject(favorites)

        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: TrackQuery())
    }
}
