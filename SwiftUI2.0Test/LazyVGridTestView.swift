//
//  LazyVGridTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct LazyVGridTestView: View {
    let colors: [Color] = [.red, .green,.yellow, .blue]
    
    //adaptive自适应，在一行或一列中放入尽可能多的Item
    //fixed完全固定的尺寸 GridItem(.fixed(50)), 需显式设置每行或每列中放入的item数量
    //flexible用法类似fixed，不过每个item的尺寸可以弹性调整，同样需要显式设置item数量
    //可以混用
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), alignment: .center), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0...100, id:\.self) { index in
                    Text("\(index)")
                        .frame(width: 110, height: 200)
                        .background(colors[index%colors.count])
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .navigationBarTitle("LazyVGrid")
    }
}

struct LazyVGridTestView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVGridTestView()
    }
}
