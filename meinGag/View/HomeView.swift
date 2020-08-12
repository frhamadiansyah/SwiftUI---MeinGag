//
//  HomeView.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 05/08/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var networkManager = NetworkManager()
    //    @State var cardCount : Int
    @State var addNewSubreddit : Bool = false
    
    init() {
        networkManager.fetchAllCard()
        //        cardCount = networkManager.subredditCover.count
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Subreddit")
                        .bold()
                    //                        .contextMenu {
                    //                            Button(action: { print("Action 1 triggered") }, label:
                    //                            {
                    //                                Text("Action 1")
                    //                            })
                    //
                    //                            Button(action: { print("action 2 triggered") }, label:
                    //                            {
                    //                                Text("Action 2")
                    //                            })
                    //                    }
                    Spacer()
                    Button(action: {
                        print("Add")
                        self.addNewSubreddit = true
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }.sheet(isPresented: $addNewSubreddit) {
                        testView(networkManager: self.networkManager)
                    }
                    //                    .alert(isPresented: $alertPresented) {
                    //                        Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                    //                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width-40, height: 25, alignment: Alignment.leading)
                ScrollView (.horizontal) {
                    //            VStack {
                    //                Text("Subreddit")
                    //                    .bold()
                    //                    .frame(width: UIScreen.main.bounds.width-40, height: 25, alignment: Alignment.leading)
                    //                ScrollView(.horizontal){
                    //                ScrollView(.horizontal) {
                    //                    HStack (spacing : 10) {
                    //                        ForEach(networkManager.subredditCover) { card in
                    //                            Image(systemName: "photo")
                    //                            SubredditCard(subredditTitle: card.name, subredditCover: card.memes[0].url)
                    //                        }
                    //                    }
                    //                }
                    //                ScrollView (.horizontal){
                    HStack{
                        ForEach(networkManager.subredditCover) {card in
                            NavigationLink(destination: ContentView(typeMemes : card.name)) {
                                SubredditCard(subredditTitle: card.name, subredditCover: card.memes[0].url)
                            }.buttonStyle(PlainButtonStyle())
                                .contextMenu {
                                    Button(action: {
                                        self.deleteSubreddit(name: card.name)
                                        
                                    }, label:
                                        {
                                            Text("Delete Subreddit")
                                                .foregroundColor(Color.red)
                                    })
                                    
                            }

                            
                        }
                    }.padding()

                    
                    Spacer()
                }
            }
            .navigationBarTitle("Home")
        }.onDisappear {
            print("lalala")
        }.onAppear {
            print("appear")
        }
    }
    
    func deleteSubreddit(name : String) {
        print("Action 1 triggered")
        let index = self.networkManager.listSubreddit.firstIndex(of: name)
        self.networkManager.listSubreddit.remove(at: index!)
        UserDefaults.standard.set(self.networkManager.listSubreddit, forKey: "array")
        var temp = [SavedData]()
        for i in self.networkManager.subredditCover {
            if i.name != name {
                temp.append(i)
            }
        }
        self.networkManager.subredditCover = temp
//        self.networkManager.subredditCover = [SavedData]()
//        self.networkManager.fetchAllCard()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct SubredditCard: View {
    var subredditTitle : String
    var subredditCover : String
    
    var body: some View {
        Group {
            ZStack {
                urlImageView(urlString: subredditCover)
                
                    
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/2, alignment: .center)
                Rectangle()                         // Shapes are resizable by default
                    .foregroundColor(.clear)        // Making rectangle transparent
                    .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .top))
                
                VStack (alignment: .center) {
                    Text(subredditTitle)
                        .foregroundColor(Color.white)
                        .bold()
                        //                        .foregroundColor(Color.green)
                        .padding()
                    Spacer()
                }
            }
            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/2, alignment: .center)
            .cornerRadius(20)
            //            .padding()
        }
    }
}
