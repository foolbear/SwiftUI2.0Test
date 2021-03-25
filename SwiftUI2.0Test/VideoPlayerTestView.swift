//
//  VideoPlayerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI
import AVKit

struct VideoPlayerTestView: View {
    private let player = AVPlayer(url: URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!)
//    private let player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
       
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear() {
                    // Start the player going, otherwise controls don't appear
                    player.play()
                }
                .onDisappear() {
                    // Stop the player when the view disappears
                    player.pause()
                }
            Divider()
            VideoPlayer(player: AVPlayer(url:  URL(string: "https://bilibili.xiang-kuyun.com/20210120/8142_67c7a1b3/index.m3u8")!)) {
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
