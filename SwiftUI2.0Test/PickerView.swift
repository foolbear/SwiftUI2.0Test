//
//  PickerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/12/11.
//

import SwiftUI

struct PickerTestView: View {
    var strengths = ["Mild", "Medium", "Mature"]
    
    @State private var selectedStrength = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedStrength, label: Text("Strength")) {
                        ForEach(0 ..< strengths.count) {
                            Text(self.strengths[$0])
                            
                        }
                    }
                }
            }.navigationBarTitle("Select your cheese")
            
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTestView()
    }
}
