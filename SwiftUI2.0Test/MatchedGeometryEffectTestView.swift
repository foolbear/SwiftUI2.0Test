//
//  MatchedGeometryEffectTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct MatchedGeometryEffectTestView: View {
    @Namespace private var animation
    @State private var isFlipped = false
    @State private var isZoomed = false
    
    var frame: CGFloat { isZoomed ? 300 : 44 }
    
//    var body: some View {
//        VStack {
//            if isFlipped {
//                Circle()
//                    .fill(Color.red)
//                    .frame(width: 44, height: 44)
//                    .matchedGeometryEffect(id: "Shape", in: animation)
//                Text("Taylor Swift – 1989")
//                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                    .font(.headline)
//            } else {
//                Text("Taylor Swift – 1989")
//                    .matchedGeometryEffect(id: "AlbumTitle", in: animation)
//                    .font(.headline)
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width: 44, height: 44)
//                    .matchedGeometryEffect(id: "Shape", in: animation)
//            }
//        }
//        .navigationTitle("MatchedGeometryEffect")
//        .onTapGesture {
//            withAnimation {
//                self.isFlipped.toggle()
//            }
//        }
//    }
    
    var body: some View {
        VStack {
            
            if isZoomed {
                HStack {
                    Text("1")
                        .matchedGeometryEffect(id: "num1", in: animation)
                    Spacer()
                    Text("2")
                        .matchedGeometryEffect(id: "num2", in: animation)
                }.padding()
            } else {
                HStack {
                    Text("2")
                        .matchedGeometryEffect(id: "num2", in: animation)
                    Spacer()
                    Text("1")
                        .matchedGeometryEffect(id: "num1", in: animation)
                }.padding()
            }
            
            Spacer()
            
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: frame, height: frame)
                        .padding(.top, isZoomed ? 20 : 0)
                    
                    if isZoomed == false {
                        Text("Taylor Swift – 1989")
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                            .font(.headline)
                        Spacer()
                    }
                }
                
                if isZoomed == true {
                    Text("Taylor Swift – 1989")
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                        .font(.headline)
                        .padding(.bottom, 60)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    self.isZoomed.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: isZoomed ? 400 : 60)
            .background(Color(white: 0.9))
        }
    }
}

struct MatchedGeometryEffectTestView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectTestView()
    }
}
