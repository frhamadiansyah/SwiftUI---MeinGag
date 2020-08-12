//
//  CellView.swift
//  meinGag
//
//  Created by Fandrian Rhamadiansyah on 12/07/20.
//  Copyright © 2020 Fandrian Rhamadiansyah. All rights reserved.
//

import SwiftUI

struct CellView: View {
    var joke : Memes
    
    var body: some View {
        VStack {
            Text(joke.title)
//            Spacer()
            urlImageView(urlString: joke.url)
            Spacer()
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(joke: Memes(postLink: "aa", url: "asd", title: "asdas"))
    }
}
