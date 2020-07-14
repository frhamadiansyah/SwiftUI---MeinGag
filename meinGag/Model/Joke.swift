//
//  Joke.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 11/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import Foundation
import UIKit

enum TypeJoke: String, CaseIterable {
    case memes
    case dankmemes
    case me_irl
}

struct Joke : Codable {
    var memes : [Memes]
}

struct Memes : Codable, Identifiable {
    
    var id : String {
        return postLink
    }
    let postLink : String
    let url : String
    let title : String
    
    var image : UIImage? {
        let imageLoader = ImageLoader(urlString: url)
        return imageLoader.image
    }
}
