//
//  ScrollViewTest.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct ScrollViewAndLazyVStackTestView: View {
    @State var position: Int = 1
    var body: some View {
        ScrollView(.vertical) {
            ScrollViewReader { scroll in
                LazyVStack(spacing: 10) {
                    Label("to position", systemImage: "checkmark.icloud")
                        .frame(width: 300, height: 100)
                        .border(Color.blue.opacity(0.5), width: 0.5)
                        .background(Color.gray)
                        .cornerRadius(6)
                        .onTapGesture {
                            withAnimation {
                                scroll.scrollTo(500, anchor: .center)
                            }
                        }
                    ForEach(0 ..< 1000) { index in
                        Text("\(index)")
                            .frame(width: 300, height: 100)
                            .border(Color.gray.opacity(0.5), width: 0.5)
                            .background(Color.blue)
                            .cornerRadius(6)
                            .id(index)
                    }
                    Text(" to top most ")
                        .frame(width: 300, height: 100)
                        .border(Color.red.opacity(0.5), width: 0.5)
                        .background(Color.yellow)
                        .cornerRadius(6)
                        .onTapGesture {
                            scroll.scrollTo(0, anchor: .center)
                        }
                }
                .onChange(of: position) { positon in
                    switch position{
                    case 1:
                        withAnimation(Animation.easeInOut){
                            scroll.scrollTo(0, anchor:.top)
                        }
                    case 2:
                        withAnimation(Animation.easeInOut){
                            scroll.scrollTo(Int(300), anchor:.center)
                        }
                    case 3:
                        withAnimation(Animation.easeInOut){
                            scroll.scrollTo(800, anchor:.bottom)
                        }
                    default:
                        break
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .toolbar {
            ToolbarItem(placement:.automatic) {
                HStack{
                    Button("top"){
                        position = 1
                    }
                    Button("mid"){
                        position = 2
                    }
                    Button("end"){
                        position = 3
                    }
                }
            }
        }
        .navigationBarTitle("Scroll View And LazyVStack")
    }
}

struct ScrollViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewAndLazyVStackTestView()
    }
}
