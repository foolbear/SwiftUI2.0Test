//
//  ImagesTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/5/17.
//

import SwiftUI

struct ImagesTestView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                Image("image0").resizable().scaledToFit().border(Color.red)
                Image("image1").resizable().scaledToFit().border(Color.red)
            }.border(Color.blue)
        }.navigationBarTitle("ImagesTestView")
    }
}

struct ImagesTestView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesTestView()
    }
}
