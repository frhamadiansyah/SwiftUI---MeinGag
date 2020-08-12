//
//  NetworkManager.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 11/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import Foundation
import SwiftUI

struct SavedData : Identifiable {
    let id = UUID()
    var name : String
    var memes : [Memes]
}

class NetworkManager : ObservableObject {
    
//    @Published var jokes : [Memes] = []
//    @Published var redditPosts = [String : [Memes]]()
//    @Published var subredditCover = [String : Memes]()
//    @Published var redditPosts = [SavedData]()
    @Published var redditPosts = [Memes]()
    @Published var subredditCover = [SavedData]()
//    @Published var jokes = [TypeJoke.memes.rawValue : [Memes](),
//                            TypeJoke.dankmemes.rawValue : [Memes](),
//                            TypeJoke.animemes.rawValue : [Memes](),
//
//    ]
    @Published var noData : Bool = false
    @Published var listSubreddit : [String]
    

    init() {
        self.listSubreddit = UserDefaults.standard.stringArray(forKey: "array") ?? [String]()

    }

    
    
    func fetchAllJokes() {
        for item in Subreddit.allCases {
            fetchData(typeMemes: item.rawValue)
        }

    }
    
    func fetchAllCard() {
        for item in listSubreddit {
            fetchCardImage(typeMemes: item)
        }
    }
    
    func fetchData(typeMemes : String) {
        guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/\(typeMemes)/50") else { return }
        print(url.absoluteString)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let sessionTask = urlSession.dataTask(with: url) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let joke = try decoder.decode(Joke.self, from: safeData)
//                        self.jokes[typeMemes] = [Memes]()
                        DispatchQueue.main.async {
                            self.redditPosts = joke.memes
//                            self.redditPosts.append(SavedData(name: typeMemes, memes: joke.memes))
//                            if self.listSubreddit.contains(typeMemes) == false {
//                                self.listSubreddit.append(typeMemes)
//                            }
                        }
                    
                    } catch  {
                        print(error)
                    }
                    
                }
            }
        }
        sessionTask.resume()
    }
    
    func fetchCardImage(typeMemes : String) {
            guard let url = URL(string: "https://meme-api.herokuapp.com/gimme/\(typeMemes)/1") else { return }
            print(url.absoluteString)
            let urlSession = URLSession(configuration: URLSessionConfiguration.default)
            
            let sessionTask = urlSession.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let joke = try decoder.decode(Joke.self, from: safeData)
    //                        self.jokes[typeMemes] = [Memes]()
                            DispatchQueue.main.async {
//                                self.subredditCover[typeMemes] = joke.memes[0]
                                self.subredditCover.append(SavedData(name: typeMemes, memes: joke.memes))
                                print("Data Inputted")
                                if self.listSubreddit.contains(typeMemes) == false {
                                    self.listSubreddit.append(typeMemes)
                                }
                                
                            }
                        
                        } catch  {
                            print(error)
                            print("asdasd")
                            DispatchQueue.main.async {
                                self.noData = true
                            }
//                            self.noData = true
                            
                        }
                        
                    }
                }
            }
            sessionTask.resume()
        }
    
}
