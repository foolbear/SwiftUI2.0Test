//
//  PickerTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/12/11.
//

import SwiftUI

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate
    case vanilla
    case strawberry

    var id: String { self.rawValue }
}

enum Topping: String, CaseIterable, Identifiable {
    case nuts
    case cookies
    case blueberries

    var id: String { self.rawValue }
}

extension Flavor {
    var suggestedTopping: Topping {
        switch self {
        case .chocolate: return .nuts
        case .vanilla: return .cookies
        case .strawberry: return .blueberries
        }
    }
}

struct PickerTestView: View {
    var strengths = ["Mild", "Medium", "Mature"]
    @State private var selectedStrength = 0
    
//    @State var suggestedTopping: Topping = .cookies
    
    var body: some View {
        Picker(selection: $selectedStrength, label: Text(strengths[selectedStrength])) {
            ForEach(0 ..< strengths.count) {
                Text(self.strengths[$0])
            }
        }.pickerStyle(MenuPickerStyle())
        
//        Picker("Suggest a topping for:", selection: $suggestedTopping) {
//            ForEach(Flavor.allCases) { flavor in
//                Text(flavor.rawValue.capitalized)
//                    .font(.caption)
//                    .tag(flavor.suggestedTopping)
//            }
//        }
//        .frame(width: 100, height: 50)
//        .clipped()
//        .border(Color.red)
//        .pickerStyle(WheelPickerStyle())
//        .pickerStyle(SegmentedPickerStyle())
////        .pickerStyle(InlinePickerStyle())
////        .pickerStyle(MenuPickerStyle())
////        .pickerStyle(SegmentedPickerStyle())
//        Text("suggestedTopping: \(suggestedTopping.rawValue)")
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTestView()
    }
}
