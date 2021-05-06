//
//  PathTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/4/27.
//

import SwiftUI

struct Track {
    var start, end: CGPoint
    var width: CGFloat { abs(start.x - end.x) }
    var height: CGFloat { abs(start.y - end.y) }
    var length: CGFloat { CGFloat(hypotf(Float(width), Float(height))) }
    var degree: Double { degress(from: start, to: end) + 90 }
}

func radians(from start: CGPoint, to end: CGPoint) -> Double {
    atan2(Double(end.y - start.y), Double(end.x - start.x))
}

func degree(fromRadians radians: Double) -> Double {
    radians * 180 / .pi
}

func degress(from start: CGPoint, to end: CGPoint) -> Double {
    degree(fromRadians: radians(from: start, to: end))
}

let width: CGFloat = 200.0
let height: CGFloat = 400.0

let tracks: [Track] = [
    Track(start: CGPoint(x: 0, y: 0), end: CGPoint(x: width, y: 0)),
    Track(start: CGPoint(x: 0, y: 0), end: CGPoint(x: width, y: -height)),
    Track(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: -height)),
    Track(start: CGPoint(x: width, y: height), end: CGPoint(x: 0, y: 0)),
    Track(start: CGPoint(x: width, y: 0), end: CGPoint(x: 0, y: 0)),
    Track(start: CGPoint(x: width, y: 0), end: CGPoint(x: 0, y: height)),
    Track(start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: height)),
    Track(start: CGPoint(x: 0, y: 0), end: CGPoint(x: width, y: height)),
]

struct PathTestView: View {
    @State private var index: Int = 0
    var track: Track { tracks[index] }
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .fill(Color.yellow)
                .border(Color.red, width: 1)
                .frame(width: track.width, height: track.height)
                .overlay(
                    FingerTrackView(track: track)
                )
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    index -= 1
                    if index < 0 {
                        index = 7
                    }
                }, label: {
                    Text("Prev")
                })
                Button(action: {
                    index = 0
                }, label: {
                    Text("Reset")
                })
                Button(action: {
                    index += 1
                    if index > 7 {
                        index = 0
                    }
                }, label: {
                    Text("Next")
                })
            }
        }
    }
}

struct FingerTrackView: View {
    var track: Track
    var prevString: String = "Prev"
    var nextString: String = "Next"
    var textDegree: Double { track.degree > 0 && track.degree < 180 ? -90 : 90 }
    var isNext: Bool { track.degree > -45 && track.degree < 135 }
    
    var body: some View {
        FingerTrack()
            .fill(Color.blue)
            .frame(width: 10, height: track.length)
            .overlay(
                Text("\(isNext ? nextString : prevString)")
                    .foregroundColor(.white)
                    .fixedSize()
                    .rotationEffect(.degrees(textDegree))
                    .padding(),
                alignment: .top)
            .rotationEffect(.degrees(track.degree))
    }
}

struct FingerTrack: Shape {
    let maxRadius: CGFloat = 40.0
    let minRatio: CGFloat = 5.0
    
    func path(in rect: CGRect) -> Path {
        let r = rect.maxY / (minRatio+1)
        let radius = r > maxRadius ? maxRadius : r
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.midX-radius, y: radius), control: CGPoint(x: rect.midX-radius, y: 0))
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY), control1: CGPoint(x: rect.midX-radius, y: radius*2), control2: CGPoint(x: rect.midX, y: radius*2))
        path.addCurve(to: CGPoint(x: rect.midX+radius, y: radius), control1: CGPoint(x: rect.midX, y: radius*2), control2: CGPoint(x: rect.midX+radius, y: radius*2))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: 0), control: CGPoint(x: rect.midX+radius, y: 0))
        return path
    }
}

struct PathTestView_Previews: PreviewProvider {
    static var previews: some View {
        PathTestView()
    }
}
