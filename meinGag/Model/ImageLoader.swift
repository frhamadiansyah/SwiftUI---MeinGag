//
//  ImageLoader.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 12/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit


class ImageLoader: ObservableObject {
    
    @Published var image : UIImage?
    var urlString : String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: urlString!) else { return }
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let sessionTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                
                guard let safeData = data else {return}
                
                DispatchQueue.main.async {
                    guard let loadedImage = UIImage(data: safeData) else { return }
                    self.image = loadedImage
                }
            }
        }
        sessionTask.resume()
    }
    
}

//{
//    do {
//        DispatchQueue.main.async {
//            let loadedImage = UIImage(data: safeData)
//        }
//
//    } catch  {
//        print(error)
//    }
//
//}
