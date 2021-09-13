//
//  Favorites.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import SwiftUI

/// Favorites model with Observable protocol so can be shared across multiple views
class Favorites: ObservableObject {
    let saveKey = "Favorites"
    
    //
    // MARK: - Variables And Properties
    //
    var favoriteTracks: Set<Int>
    
    //
    // MARK: - Initialization
    //
    init() {
        /// Load save data, if any, then exit
        let userRepository: UserRepository = UserRepository()
        if userRepository.getFavoriteTracks() != nil {
            let favoritesArray = userRepository.getFavoriteTracks()
            favoriteTracks = Set(favoritesArray ?? [])
            return
        }

        /// Initialize, if no saved data
        self.favoriteTracks = []
    }
    
    //
    // MARK: - Internal Functions
    //
    func contains(_ track: Track) -> Bool {
        favoriteTracks.contains(track.trackId)
    }
    
    func add(_ track: Track) {
        objectWillChange.send()
        favoriteTracks.insert(track.trackId)
        save()
    }
    
    func remove(_ track: Track) {
        objectWillChange.send()
        favoriteTracks.remove(track.trackId)
        save()
    }

    /// Save favorites to UserDefaults
    func save() {
        UserRepository().saveFavoriteTracks(favorites: Array(favoriteTracks))
    }
}
