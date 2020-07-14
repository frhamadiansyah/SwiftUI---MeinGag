//
//  urlImageView.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 12/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import SwiftUI

struct urlImageView: View {
    @ObservedObject var imageLoader : ImageLoader
    
    static var defaultImage = UIImage(systemName: "photo")//Image(systemName: "photo")
    
    init(urlString: String?) {
        imageLoader = ImageLoader(urlString: urlString)

//        if let jokeImage = imageLoader.image {
//            urlImageView.defaultImage = Image(uiImage: jokeImage)
//        }
    }
    
    
    
    var body: some View {
        HStack {
//            Spacer()
            if imageLoader.image == nil {
                Image(systemName: "arrow.2.circlepath")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(360))
            } else {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .scaledToFit()
            }
//            Image(uiImage: imageLoader.image ?? urlImageView.defaultImage!)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100.0, height: 100.0)
//            Spacer()
        }
    }
    

}

struct urlImageView_Previews: PreviewProvider {
    static var previews: some View {
        urlImageView(urlString: nil)
    }
}
