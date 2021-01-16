//
//  TabViewTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct TabViewTestView: View {
    let colors: [Color] = [.red, .green,.yellow, .blue]
    
    var body: some View {
        TabView {
            ForEach(0..<9) { index in
                Text("\(index)")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colors[index%colors.count])
                    .cornerRadius(8)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .padding()
        .navigationBarTitle("Tab View")
    }
}

struct TabViewTestView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewTestView()
    }
}
