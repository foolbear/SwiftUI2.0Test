//
//  NavigationTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/1/6.
//

import SwiftUI

struct NavigationTestView: View {
    @State private var showSheet = false
    @State private var showFullScreenCover = false
    
    var body: some View {
        VStack {
            Button("showSheet") {
                showSheet = true
            }
            .sheet(isPresented: $showSheet, content: { NaviView(showAsSheet: $showSheet, showAsFullScreenCover: $showFullScreenCover) })
            Button("showFullScreenCover") {
                showFullScreenCover = true
            }
            .fullScreenCover(isPresented: $showFullScreenCover, content: { NaviView(showAsSheet: $showSheet, showAsFullScreenCover: $showFullScreenCover) })
        }
        .navigationTitle("Navigation Test")
    }
}

struct NaviView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var hideBar = false
    @State private var destination: Int? = nil
    @State private var isActive: Bool = false
    @Binding var showAsSheet: Bool
    @Binding var showAsFullScreenCover: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("FirstView", destination: FirstView(), tag: 1, selection: $destination)
                NavigationLink("SecondView", destination: SecondView(), tag: 2, selection: $destination)
                NavigationLink("ThirdView", destination: ThirdView(), isActive: $isActive)
                Divider()
                Button("goto FirstView") {
                    destination = 1
                }
                Button("goto SecondView") {
                    destination = 2
                }
                Button("goto ThirdView") {
                    isActive = true
                }
                Button("hideBar") {
                    hideBar.toggle()
                }
            }
            .navigationTitle("NaviView")
            .navigationBarItems(leading: Button("binding Close", action: {
                showAsFullScreenCover = false
                showAsSheet = false
            }), trailing: Button("Close", action: { presentationMode.wrappedValue.dismiss() }))
            .navigationBarHidden(hideBar)
        }
        .statusBar(hidden: hideBar)
    }
}

struct FirstView: View {
    var body: some View {
        Text("FirstView")
            .navigationTitle("FirstView")
    }
}

struct SecondView: View {
    var body: some View {
        Text("SecondView")
            .navigationTitle("SecondView")
    }
}

struct ThirdView: View {
    var body: some View {
        Text("ThirdView")
            .navigationTitle("ThirdView")
    }
}

struct NavigationTestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTestView()
    }
}
