//
//  TrackImageLoader.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import UIKit

class TrackImageLoader: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    func loadImage(for urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        
        task.resume()
    }
}
