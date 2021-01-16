//
//  AppStoreOverlayTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI
import StoreKit

struct AppStoreOverlayTestView: View {
    @State private var showRecommended = false
    var body: some View {
        VStack {
            Button("Show Recommended App") {
                self.showRecommended.toggle()
            }
            .appStoreOverlay(isPresented: $showRecommended) {
                SKOverlay.AppConfiguration(appIdentifier: "1440611372", position: .bottom)
            }
        }.navigationTitle("AppStore Overlay")
    }
}

struct AppStoreOverlayTestView_Previews: PreviewProvider {
    static var previews: some View {
        AppStoreOverlayTestView()
    }
}
