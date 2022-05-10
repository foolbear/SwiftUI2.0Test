//
//  AnimationTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/1/5.
//

import SwiftUI

struct RotationEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var rotation: Bool {
        get { self[RotationEnvironmentKey.self] }
        set { self[RotationEnvironmentKey.self] = newValue }
    }
}

struct AnimationTestView: View {
    @State private var go = false
    @State private var rotation = false
    var body: some View {
        VStack {
            Button("Go!") {
//                withAnimation(.easeInOut(duration: 3.0)) {
                    go.toggle()
//                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    rotation.toggle()
                    print("set rotation = \(rotation)")
                }
            }
            Group {
                if go {
                    RectangleView()
                        .transition(.slide)
                        .environment(\.rotation, rotation)
                }
            }.animation(.easeInOut(duration: 3.0), value: go)
        }.navigationTitle("Animation Test")
    }
}

struct RectangleView: View {
    var body: some View {
        Rectangle()
            .frame(width: 200, height: 100)
            .foregroundColor(.pink)
            .overlay(TextView())
    }
}

struct TextView: View {
    @Environment(\.rotation) var rotation
    @State private var animationRotating: Bool = false
    let animation = Animation.linear(duration: 3.0).repeatForever(autoreverses: false)
    
    var body: some View {
        let _ = print("refresh, rotation = \(rotation)")
        HStack {
            Spacer()
            //            if rotation {
            //                Text("R")
            //                    .foregroundColor(.blue)
            //                    .rotationEffect(.degrees(animationRotating ? 360 : 0))
            //                    .animation(animation, value: animationRotating)
            //                    .onAppear { animationRotating = true }
            //                    .onDisappear { animationRotating = false }
            //            } else {
            //                Text("S")
            //            }
            
            Text(rotation ? "R" : "S")
                .foregroundColor(rotation ? .blue : .white)
                .rotationEffect(.degrees(animationRotating ? 360 : 0))
                .animation(rotation ? animation : nil, value: animationRotating)
                .onChange(of: rotation) { newValue in
                    animationRotating = true
                }
        }
    }
}

//struct AnimationTextView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimationTextView()
//    }
//}
