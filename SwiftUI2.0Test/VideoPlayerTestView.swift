//
//  VideoPlayerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI
import AVKit

struct VideoPlayerTestView: View {
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url:  URL(string: "https://vod-progressive.akamaized.net/exp=1604411870~acl=%2A%2F1123020046.mp4%2A~hmac=6c08c50f1cc185a1b6d1f2a8c5a34439d858eadc155295f996ae4a0d7b0bca97/vimeo-prod-skyfire-std-us/01/4047/11/295238750/1123020046.mp4?filename=What+Star+Wars+Can+Teach+Us+About+Swift.mp4")!)) {
                VStack {
                    Text("Watermark")
                        .font(.caption)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Capsule())
                    Spacer()
                }
            }
        }.navigationTitle("VideoPlayer")
    }
}

struct VideoPlayerTestView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerTestView()
    }
}
