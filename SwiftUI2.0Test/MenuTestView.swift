//
//  MenuTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct MenuTestView: View {
    @State private var selectedIndex = 0
    var colorText:[String] = ["红","黄","绿"]
    
    var body: some View {
        VStack {
            Spacer()
            Menu {
                Text("Choose")
                Button("Hello1"){}
                Button("Hello2"){}
            }
            label: {
                Image(systemName: "folder.fill")
                Text("PDF")
            }
            Spacer()
            Menu("菜单"){
                Picker("选择颜色", selection: $selectedIndex) {
                    ForEach(0..<self.colorText.count){
                        index in
                        Text(colorText[index])
                    }
                }
            }
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement:ToolbarItemPlacement.automatic){
                Menu("Menu"){
                    Text("Choose")
                    Button("Test1"){}
                    Button("Test2"){}
                    Button("Test3"){}
                    Menu("Menu4"){
                        Button("Test41"){}
                        Button("Test42"){}
                        Button("Test43"){}
                    }
                }
                .menuStyle(BorderlessButtonMenuStyle())
            }
        }
        .navigationTitle("Menu")
    }
}

struct MenuTestView_Previews: PreviewProvider {
    static var previews: some View {
        MenuTestView()
    }
}
