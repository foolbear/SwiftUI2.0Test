//
//  TextEditorTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct TextEditorTestView: View {
    @State var content: String = "hello, world"
    
    var body: some View {
        VStack(spacing: 8) {
            Text(content)
            TextEditor(text: $content)
        }
        .padding()
        .navigationBarTitle("Text Editor")
    }
}

struct TextEditorTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorTestView()
    }
}
