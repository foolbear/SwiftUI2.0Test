//
//  TextFieldTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct TextFieldTestView: View {
    @State var text: String = "Hello, world"
    
    var body: some View {
        VStack(spacing: 8) {
            Text("count: \(text.count)")
            Text(text)
            Button("Clear") { text = "" }
            TextField("placeholder", text: $text).padding()
        }.navigationTitle("Text Field")
    }
}

struct TextFieldTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldTestView()
    }
}
