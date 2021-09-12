//
//  Favorites.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import SwiftUI

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
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: saveKey) as? [Int]) != nil {
            let favoritesArray = defaults.object(forKey: saveKey) as? [Int]
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
        let defaults = UserDefaults.standard
        defaults.set(Array(favoriteTracks), forKey: saveKey)
    }
}
