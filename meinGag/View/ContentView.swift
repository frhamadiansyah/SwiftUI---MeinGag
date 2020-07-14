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
    @State private var selectorIndex = 0
    @State private var numbers = ["memes", "dankmemes", "me_irl"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Picker("Numbers", selection: $selectorIndex) {
                        ForEach(0 ..< numbers.count) { index in
                            Text(self.numbers[index])//.tag(index)
    //                        print("hahaha")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Spacer()
                }
                
                List(networkManager.jokes[numbers[selectorIndex]]!) { joke in
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
                .navigationBarTitle("Mein Gag")
                .onTapGesture {
                    print("lalalala")
                }
                .onAppear {
                    print(self.numbers[self.selectorIndex])
                    self.networkManager.fetchAllJokes()
                }
            }
        }
        
    }
    
    func reload() {
        print("ahaha")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


