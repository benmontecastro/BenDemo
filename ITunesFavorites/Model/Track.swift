//
//  Track.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import Foundation
import SwiftUI

/// Track (Itunes data item) model with Observable protocol so can be shared across multiple views
class Track: ObservableObject {
    let trackId: Int
    let trackName: String
    let artistName: String
    let price: Double
    let currency: String
    let genre: String
    let description: String
    let imageUrl: URL
    
    //
    // MARK: - Variables And Properties
    //
    /// Not used - delete later
    var imageName: String = "ico_placeholder"
    var image: Image {
        Image(imageName)
    }
    
    //
    // MARK: - Initialization
    //
    init(id: Int, name: String, artist: String, price: Double, currency: String, genre: String, description: String, imageUrl: URL) {
        self.trackId = id
        self.trackName = name
        self.artistName = artist
        self.price = price
        self.currency = currency
        self.genre = genre
        self.description = description
        self.imageUrl = imageUrl
    }
    
    //
    // MARK: - Internal Methods
    //
    func isFavorite() -> Bool {
        return Favorites().contains(self)
    }
}
