//
//  DarkModeTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/2/7.
//

import SwiftUI

struct DarkModeTestView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        print("refreshing"); return
        Text(colorScheme == .dark ? "In dark mode" : "In light mode")
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .navigationBarTitle("Dark Mode Test")
    }
}

struct DarkModeTestView_Previews: PreviewProvider {
    static var previews: some View {
        DarkModeTestView()
    }
}
