//
//  ProgressViewTest.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct ProgressViewTestView: View {
    @State var progress: Double = 0.0
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                .scaleEffect(2.0)
                .padding()
            ProgressView("progress of something", value: progress, total: 100)
                .padding()
            Slider(value: $progress, in: 0...100)
                .padding()
        }.navigationBarTitle("Progress View")
    }
}

struct ProgressViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewTestView()
    }
}
