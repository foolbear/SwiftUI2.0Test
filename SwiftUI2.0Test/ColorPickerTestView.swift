//
//  ColorPickerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct ColorPickerTestView: View {
    @State var color: Color = .red
    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .fill(color)
                .frame(width: 200, height: 200)
                .cornerRadius(8)
            ColorPicker("Pick a color", selection: $color)
                .padding()
        }.navigationBarTitle("Color Picker")
    }
}

struct ColorPickerTestView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerTestView()
    }
}
