//
//  FontTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/12/22.
//

import SwiftUI

struct FontTestView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(Font.TextStyle.allCases, id: \.self) { style in
                    HStack {
                        Text("\(style)" as String).font(Font.system(style))
                        Spacer()
                    }
                }
            }.padding()
        }
    }
}

struct FontTestView_Previews: PreviewProvider {
    static var previews: some View {
        FontTestView()
    }
}
