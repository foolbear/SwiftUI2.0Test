//
//  DisclosureGroupTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct Author {
    let name: String
    let books: [String]
}
struct DisclosureGroupTestView: View {
    let authors = [
        Author(name: "伊坂幸太郎", books: ["孩子們", "家鴨與野鴨的投幣式置物櫃", "重力小丑", "奧杜邦的祈禱"]),
        Author(name: "乙一", books: ["夏天、煙火、我的屍體", "GOTH斷掌事件", "暗黑童話"])
    ]
    
    var body: some View {
        VStack {
            DisclosureGroup(
                content: {
                    VStack(alignment: .leading) {
                        ForEach(authors, id: \.name) { (author) in
                            DisclosureGroup(author.name) {
                                VStack(alignment: .leading) {
                                    ForEach(author.books, id: \.self) { (book)  in
                                        Text(book)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                },
                label: {
                    Label("日本推理作家", systemImage: "text.book.closed.fill")
                }
            )
            .padding()
            Spacer()
        }.navigationTitle("DisclosureGroup")
    }
}

struct DisclosureGroupTestView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupTestView()
    }
}
