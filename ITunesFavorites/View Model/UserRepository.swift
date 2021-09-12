//
//  UserRepository.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import Foundation

class UserRepository {
    //
    // MARK: - Variables And Properties
    //
    var userDefaults: UserDefaults
    
    //
    // MARK: - Initialization
    //
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    //
    // MARK: - Internal Methods
    //
    func getDateOfLastVisit() -> Date? {
        return userDefaults.object(forKey: "DateOfLastVisit") as? Date ?? Date()
    }
    
    func saveDateOfLastVisit(date: Date) {
        userDefaults.set(date, forKey: "DateOfLastVisit")
    }
    
    func getFavoriteTracks() -> [Int]? {
        return userDefaults.object(forKey: "Favorites") as? [Int] ?? []
    }
    
    func saveFavoriteTracks(favorites: [Int]) {
        userDefaults.set(favorites, forKey: "Favorites")
    }
    
    func getShowFavorites() -> Bool? {
        return userDefaults.object(forKey: "ShowFavorites") as? Bool ?? false
    }
    
    func saveShowFavorites(show: Bool) {
        userDefaults.set(show, forKey: "ShowFavorites")
    }
    
    func getSearchText() -> String? {
        return userDefaults.object(forKey: "SearchText") as? String ?? ""
    }
    
    func saveShowFavorites(text: String) {
        userDefaults.set(text, forKey: "SearchText")
    }

}
