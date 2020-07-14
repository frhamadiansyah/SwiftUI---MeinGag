//
//  NetworkManager.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 11/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import Foundation

class NetworkManager : ObservableObject {
    
    @Published var jokes : [Memes] = []
    
    
    func fetchData(typeMemes : String) {
        guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/\(typeMemes)/10") else { return }
        print(url.absoluteString)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let sessionTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let joke = try decoder.decode(Joke.self, from: safeData)
                        DispatchQueue.main.async {
                            self.jokes = joke.memes
                        }
                    
                    } catch  {
                        print(error)
                    }
                    
                }
            }
        }
        sessionTask.resume()
    }
    
}
