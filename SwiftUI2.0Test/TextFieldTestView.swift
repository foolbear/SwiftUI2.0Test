//
//  TextFieldTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct TextFieldTestView: View {
    @State var text: String = "Hello, world"
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 8) {
            Text("count: \(text.count)")
            Text(text)
            Button("Clear") { text = "" }
            TextField("placeholder", text: $text).padding()
            Divider()
            
            HStack {
                TextField("Username", text: $username)
                    .foregroundColor(.secondary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                if username.isEmpty == false {
                    Button(action: { username = "" }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                }
            }.padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.password)
                .padding()
        }.navigationTitle("Text Field")
    }
}

struct TextFieldTestView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldTestView()
    }
}
