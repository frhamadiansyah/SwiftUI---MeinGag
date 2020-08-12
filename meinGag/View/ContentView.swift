//
//  ContentView.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 10/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @ObservedObject var networkManager = NetworkManager()
    var typeMemes : String


    init(typeMemes : String) {
        self.typeMemes = typeMemes
        networkManager.fetchData(typeMemes: typeMemes)
    }


    var body: some View {
//        NavigationView {
            VStack {
               

                List(networkManager.redditPosts) { joke in
                    NavigationLink(destination: CellView(joke: joke)) {
                        VStack {
                            HStack {
                                Spacer()
                                Text(joke.title)
                                    .multilineTextAlignment(TextAlignment.center)
                                    .padding()
                                Spacer()
                            }
                            urlImageView(urlString: joke.url)

                        }.padding()
                    }

                }
                .navigationBarTitle(typeMemes)
            }
//        }

    }

    func reload() {
        print("ahaha")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(typeMemes: "memes")
    }
}


