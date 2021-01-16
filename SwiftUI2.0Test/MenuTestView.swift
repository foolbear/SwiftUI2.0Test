//
//  MenuTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct MenuTestView: View {
    var body: some View {
        Menu {
            Button("Hello1"){}
            Button("Hello2"){}
        }
        label: {
            Image(systemName: "folder.fill")
            Text("PDF")
        }
        .toolbar{
            ToolbarItem(placement:ToolbarItemPlacement.automatic){
                Menu("Menu"){
                    Button("Test1"){}
                    Button("Test2"){}
                    Button("Test3"){}
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
