//
//  SheetTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case actionSheet3, actionSheet4, actionSheet6
    public var id: ActiveSheet { self }
}

struct SheetItem: Identifiable {
    var id: ActiveSheet { actionSheet }
    var actionSheet: ActiveSheet
    var text: String?
}

struct SheetTestView: View {
    @State var showView1 = false
    @State var showView2 = false
    @State var showView34: SheetItem? = nil
    @State var showView5 = false
    @State var text = "hello world";
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text(text)
            
//            HStack {
//                Button("View1") {
//                    showView1.toggle()
//                }
//                .sheet(isPresented:$showView1) {
//                    Text("View1")
//                }
//
//                Button("View2") {
//                    showView2.toggle()
//                }
//                .sheet(isPresented:$showView2) {
//                    Text("View2")
//                }
//            }
//
//            Button("fullScreenCover") {
//                showView5.toggle()
//            }
//            .fullScreenCover(isPresented:$showView5) {
//                fullScreenCoverView()
//            }
            
            HStack {
                Button("View3") {
                    showView34 = SheetItem(actionSheet: .actionSheet3, text: nil)
                }
                Button("View4"){
                    showView34 = SheetItem(actionSheet: .actionSheet4, text: nil)
                }
                Button("View6"){
                    showView34 = SheetItem(actionSheet: .actionSheet6, text: text)
                }
            }
            .sheet(item: $showView34) { item in
                switch item.actionSheet {
                case .actionSheet3: Text("View3")
                case .actionSheet4: Text("View4")
                default: Text("View5: \(item.text ?? "")")
                }
            }

        }.navigationTitle("Sheet")
    }
}

struct fullScreenCoverView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Text("fullScreenCoverView")
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct SheetTestView_Previews: PreviewProvider {
    static var previews: some View {
        SheetTestView()
    }
}
