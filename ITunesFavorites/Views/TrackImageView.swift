//
//  TrackImageView.swift
//  ITunesFavorites
//
//  Created by Ben Montecastro on 12/9/21.
//

import SwiftUI

struct TrackImageView: View {
    var urlString: String
    
    @ObservedObject var imageLoader = TrackImageLoader()
    @State var image: UIImage = UIImage(named: "ico_placeholder") ?? UIImage()
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 30, height: 30)
            .onReceive(imageLoader.$image, perform: { image in
                self.image = image
            })
            .onAppear {
                imageLoader.loadImage(for: urlString)
            }
    }
}

struct TrackImageView_Previews: PreviewProvider {
    static var previews: some View {
        TrackImageView(urlString: "")
    }
}
