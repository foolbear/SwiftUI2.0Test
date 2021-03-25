//
//  ShadowTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/2/18.
//

import SwiftUI

struct ShadowTestView: View {
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<6) {
                    Color.red.frame(width: 30, height: 60, alignment: .center)
                        .overlay(Text("\($0)"),
                                 alignment: .bottom)
                        .shadow(color: Color.gray,
                                radius: 5.0,
                                x: CGFloat($0),
                                y: CGFloat($0))
                }
            }
            Text("100")
                .bold()
                .font(.system(size: 60))
                .foregroundColor(.black)
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
            Text("100")
                .bold()
                .font(.system(size: 60))
                .foregroundColor(.black)
                .shadow(color: Color.gray, radius: 1)
            Text("100")
                .bold()
                .font(.system(size: 60))
                .foregroundColor(.white)
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
            Text("100")
                .bold()
                .font(.system(size: 60))
                .foregroundColor(.white)
                .shadow(color: Color.gray, radius: 1)
        }.navigationTitle("Shadow")
    }
}

struct ShadowTestView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowTestView()
    }
}
