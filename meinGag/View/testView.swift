//
//  testView.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 05/08/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import SwiftUI

struct testView: View {
    @State var subreddit : String = ""
    @ObservedObject var networkManager : NetworkManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State private var error = false
    
    var body: some View {
        //        ScrollView (.vertical){
        //            VStack{
        //                ForEach(0 ..< 100) {_ in
        //                    Image(systemName: "photo")
        //                    .resizable()
        //                        .frame(width: 100, height: 100, alignment: .center)
        //                }
        //            }
        //        }
        VStack {
            Text("Add new subreddit")
                .padding()
            TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $subreddit)
                .padding()
            
            Image(systemName: "photo")
                .padding()
            Button(action: {
                self.addSubreddit()
                
            }) {
                Text("Add Subreddit")
            }.padding()
                .alert(isPresented: $showingAlert) { () -> Alert in
                alertButton()
            }
            
        }.frame(width: UIScreen.main.bounds.width*0.9, alignment: .center)
        
    }
    
    func alertButton() -> Alert {
        if error == false {
            return Alert.init(title: Text("Subreddit Added"), message: Text("\(subreddit) subreddit is added to your list"), dismissButton: Alert.Button.default(Text("Okay"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        } else {
            return Alert.init(title: Text("Error"), message: Text("Cannot add subreddit. Please check for typos"), dismissButton: Alert.Button.default(Text("Okay"), action: {
//                self.presentationMode.wrappedValue.dismiss()
                self.subreddit = ""
                self.networkManager.noData = false
            }))
        }
        
    }
    
    func addSubreddit() {
        if self.networkManager.noData {
            self.error = true
            self.showingAlert = true
        } else {
            if self.networkManager.listSubreddit.contains(self.subreddit) == false {
                        self.error = false
                        print(self.networkManager.listSubreddit)
                        self.networkManager.fetchCardImage(typeMemes: self.subreddit)
                        self.networkManager.listSubreddit.append(self.subreddit)
                        UserDefaults.standard.set(self.networkManager.listSubreddit, forKey: "array")
                        self.showingAlert = true
            //            self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.error = true
                        self.showingAlert = true
                    }
        }
        
    }
}

//struct testView_Previews: PreviewProvider {
//    static var previews: some View {
//        testView()
//    }
//}
