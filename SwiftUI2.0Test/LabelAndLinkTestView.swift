//
//  LabelAndLinkTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct LabelAndLinkTestView: View {
    var body: some View {
        VStack(spacing: 8) {
            Label("SwiftUI 2.0", systemImage: "checkmark.icloud")
            Link(destination: URL(string: "http://www.baidu.com")!) {
                Text("goto baidu")
            }
            Text("Attributed ").foregroundColor(.orange).kerning(0).font(.custom("Chalkduster", size: 25)) + Text("string").foregroundColor(.black).font(.custom("Chalkduster", size: 25))
            
        }.navigationBarTitle("Label And Link")
    }
}

struct LabelAndLinkTestView_Previews: PreviewProvider {
    static var previews: some View {
        LabelAndLinkTestView()
    }
}
