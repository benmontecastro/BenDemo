//
//  TrackQuery.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 11/9/21.
//

import Foundation

/// HTTP session helper
class TrackQuery {
    //
    // MARK: - Constants
    //
    let defaultSession = URLSession(configuration: .default)

    //
    // MARK: - Variables And Properties
    //
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var tracksData: [Track] = []
    
    //
    // MARK: - Type Alias
    //
    typealias JSONDictionary = [String: Any]
    typealias QueryResult = ([Track]?, String) -> Void
    
    //
    // MARK: - Initialization
    //
    init() {
        self.getTracks() { results, error in
            if let results = results {
                self.tracksData = results
            }
        }
    }
    
    //
    // MARK: - Internal Methods
    //
    func getTracks(completion: @escaping QueryResult) {
        /// Cancel existing data task, if any
        dataTask?.cancel()
            
        /// Set url of GET request using URLComponents to properly escape characters
        if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
          urlComponents.query = "term=star&country=au&media=movie&all"
          /// Unwrap to url
          guard let url = urlComponents.url else {
            return
          }
          /// Initialize data task object with url and completion handler
          dataTask =
            defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
              self?.dataTask = nil
            }
            /// Handle response data
            if let error = error {
              self?.errorMessage += "getTracks error: " +
                                      error.localizedDescription + "\n"
            } else if
              let data = data,
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 {
                
                /// Load Response data to tracksData
                self?.parseTracksData(data)
                
                /// Switch to main thread and pass tracks array
                DispatchQueue.main.async {
                    completion(self?.tracksData, self?.errorMessage ?? "")
                }
            }
          }
          /// Start data task
          dataTask?.resume()
        }
    }
    
    //
    // MARK: - Private Methods
    //
    private func parseTracksData(_ data: Data) {
      var response: JSONDictionary?
        tracksData.removeAll()
      
      do {
        response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
      } catch let parseError as NSError {
        errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
        return
      }
      
      guard let array = response!["results"] as? [Any] else {
        errorMessage += "Response does not contain results key\n"
        return
      }
      
      for trackDictionary in array {
        if let trackDictionary = trackDictionary as? JSONDictionary,
            let id = trackDictionary["trackId"] as? Int,
            let name = trackDictionary["trackName"] as? String,
            let artist = trackDictionary["artistName"] as? String,
            let price = trackDictionary["trackPrice"] as? Double,
            let currency = trackDictionary["currency"] as? String,
            let genre = trackDictionary["primaryGenreName"] as? String,
            let description = trackDictionary["longDescription"] as? String,
            let imageURLString = trackDictionary["artworkUrl30"] as? String,
            let imageURL = URL(string: imageURLString) {
            tracksData.append(Track(id: id, name: name, artist: artist, price: price, currency: currency, genre: genre, description: description, imageUrl: imageURL))
        } else {
          errorMessage += "Problem parsing trackDictionary\n"
        }
      }
    }

}
