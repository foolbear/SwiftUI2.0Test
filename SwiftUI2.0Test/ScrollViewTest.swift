//
//  ScrollViewTest.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct ScrollViewTestView: View {
    var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { scroll in
                LazyHStack(spacing: 10) {
                    Text(" to position ")
                        .frame(width: 100, height: 200)
                        .border(Color.blue.opacity(0.5), width: 0.5)
                        .background(Color.gray)
                        .cornerRadius(6)
                        .onTapGesture {
                            scroll.scrollTo(999, anchor: .center)
                        }
                    ForEach(0 ..< 1000) { index in
                        Text("\(index)")
                            .frame(width: 100, height: 200)
                            .border(Color.gray.opacity(0.5), width: 0.5)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                }.padding(.horizontal, 10)
            }
        }.navigationBarTitle("Scroll View")
    }
}

struct ScrollViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewTestView()
    }
}
