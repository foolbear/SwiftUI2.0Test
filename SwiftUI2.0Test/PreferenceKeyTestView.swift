//
//  PreferenceKeyTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/1/16.
//

import SwiftUI

//FYI:
//https://zhuanlan.zhihu.com/p/136153810
//https://zhuanlan.zhihu.com/p/139403431

struct PreferenceKeyTestView: View {
    var body: some View {
        VStack {
            Group {
                Spacer()
                EasyExample().frame(height: 200)
                Spacer()
            }
            Divider()
            Group {
                Spacer()
                MediumExample().frame(height: 200)
                Spacer()
            }
            Divider()
            Group {
                Spacer()
                HardExample().frame(height: 200)
                Spacer()
            }
        }
        .font(.caption)
        .navigationBarTitle("PreferenceKey Test")
    }
}

struct HardExample : View {
    struct MyTextPreferenceData {
        let viewIdx: Int
        let bounds: Anchor<CGRect>
    }
    
    struct MyTextPreferenceKey: PreferenceKey {
        typealias Value = [MyTextPreferenceData]

        static var defaultValue: [MyTextPreferenceData] = []

        static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    @State private var activeIdx: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
            }
            
            Spacer()
        }.backgroundPreferenceValue(MyTextPreferenceKey.self) { preferences in
            GeometryReader { geometry in
                self.createBorder(geometry, preferences)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
    
    func createBorder(_ geometry: GeometryProxy, _ preferences: [MyTextPreferenceData]) -> some View {
        let p = preferences.first(where: { $0.viewIdx == self.activeIdx })
        let bounds = p != nil ? geometry[p!.bounds] : .zero
        return RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 3.0)
            .foregroundColor(Color.green)
            .frame(width: bounds.size.width, height: bounds.size.height)
            .fixedSize()
            .offset(x: bounds.minX, y: bounds.minY)
            .animation(.easeInOut(duration: 1.0))
    }
    
    struct MonthView: View {
        @Binding var activeMonth: Int
        let label: String
        let idx: Int

        var body: some View {
            Text(label)
                .padding(10)
                .onTapGesture { self.activeMonth = self.idx }
                .anchorPreference(
                    key: MyTextPreferenceKey.self,
                    value: .bounds,
                    transform: { [MyTextPreferenceData(viewIdx: self.idx, bounds: $0)] })
        }
    }
}

struct MediumExample : View {
    struct MyTextPreferenceData: Equatable {
        let viewIdx: Int
        let rect: CGRect
    }

    struct MyTextPreferenceKey: PreferenceKey {
        typealias Value = [MyTextPreferenceData]

        static var defaultValue: [MyTextPreferenceData] = []
        
        static func reduce(value: inout [MyTextPreferenceData], nextValue: () -> [MyTextPreferenceData]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    @State private var activeIdx: Int = 0
    @State private var rects: [CGRect] = Array<CGRect>(repeating: CGRect(), count: 12)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0)
                .foregroundColor(Color.green)
                .frame(width: rects[activeIdx].size.width, height: rects[activeIdx].size.height)
                .offset(x: rects[activeIdx].minX, y: rects[activeIdx].minY)
                .animation(.easeInOut(duration: 1.0))
            
            VStack {
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                    MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                    MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                    MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
                }
                
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                    MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                    MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                    MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
                }
                
                Spacer()
                
                HStack {
                    MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                    MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                    MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                    MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
                }
                
                Spacer()
            }.onPreferenceChange(MyTextPreferenceKey.self) { preferences in
                print("onPreferenceChange")
                for p in preferences {
                    self.rects[p.viewIdx] = p.rect
                }
            }
        }.coordinateSpace(name: "myZstack")
    }
    
    struct MonthView: View {
        @Binding var activeMonth: Int
        let label: String
        let idx: Int
        
        var body: some View {
            Text(label)
                .padding(10)
                .onTapGesture { self.activeMonth = self.idx }
                .background(MyPreferenceViewSetter(idx: idx))
        }
    }

    struct MyPreferenceViewSetter: View {
        let idx: Int
        
        var body: some View {
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.clear)
                    .preference(
                        key: MyTextPreferenceKey.self,
                        value: [MyTextPreferenceData(viewIdx: self.idx, rect: geometry.frame(in: .named("myZstack")))])
            }
        }
    }
}

struct EasyExample : View {
    @State private var activeIdx: Int = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "January", idx: 0)
                MonthView(activeMonth: $activeIdx, label: "February", idx: 1)
                MonthView(activeMonth: $activeIdx, label: "March", idx: 2)
                MonthView(activeMonth: $activeIdx, label: "April", idx: 3)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "May", idx: 4)
                MonthView(activeMonth: $activeIdx, label: "June", idx: 5)
                MonthView(activeMonth: $activeIdx, label: "July", idx: 6)
                MonthView(activeMonth: $activeIdx, label: "August", idx: 7)
            }
            
            Spacer()
            
            HStack {
                MonthView(activeMonth: $activeIdx, label: "September", idx: 8)
                MonthView(activeMonth: $activeIdx, label: "October", idx: 9)
                MonthView(activeMonth: $activeIdx, label: "November", idx: 10)
                MonthView(activeMonth: $activeIdx, label: "December", idx: 11)
            }
            
            Spacer()
        }
    }
    
    struct MonthView: View {
        @Binding var activeMonth: Int
        let label: String
        let idx: Int
        
        var body: some View {
            Text(label)
                .padding(10)
                .onTapGesture { self.activeMonth = self.idx }
                .background(MonthBorder(show: activeMonth == idx))
        }
    }
    
    struct MonthBorder: View {
        let show: Bool
        
        var body: some View {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3.0).foregroundColor(show ? Color.red : Color.clear)
                .animation(.easeInOut(duration: 0.6))
        }
    }
}

struct PreferenceKeyTestView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeyTestView()
    }
}
