//
//  OnChangeTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI
import AVFoundation

struct OnChangeTestView: View {
    @State var isPlay: Bool = false
    let player = AVPlayer(url: URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/Music1/v4/ab/3e/54/ab3e546a-ceb8-0d53-5169-9f1d6d55586c/mzaf_4788478901280424198.plus.aac.p.m4a")!)
    
    var body: some View {
        VStack(spacing: 8) {
            Toggle("Player", isOn: $isPlay)
        }
        .onChange(of: isPlay) { value in
            if value {
                player.play()
            } else {
                player.pause()
            }
        }
        .padding()
        .navigationBarTitle("onChange")
    }
}

struct OnChangeTestView_Previews: PreviewProvider {
    static var previews: some View {
        OnChangeTestView()
    }
}
