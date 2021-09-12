//
//  Track.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import Foundation
import SwiftUI

class Track {
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
    var favorite = false
    var imageName: String = "iPhone 29x29pt"
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
}
