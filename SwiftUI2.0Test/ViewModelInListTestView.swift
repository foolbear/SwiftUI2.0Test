//
//  ViewModelInListTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/3/29.
//

import SwiftUI
import Combine

struct Item: Identifiable {
    var index: Int
    var favorite: Bool
    var id: Int { index }
}

class Model: ObservableObject {
    @Published var items = [
        Item(index: 0, favorite: true),
        Item(index: 1, favorite: false),
        Item(index: 2, favorite: true),
        Item(index: 3, favorite: false),
        Item(index: 4, favorite: true),
        Item(index: 5, favorite: false),
        Item(index: 6, favorite: true),
        Item(index: 7, favorite: false),
    ]
}

struct ViewModelInListTestView: View {
    @StateObject var model = Model()
    var body: some View {
        print("ViewModelInListTestView refreshing"); return
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 4, alignment: .center)], spacing: 4) {
                ForEach(model.items.indices) { index in
                    ItemView(item: model.items[index])
                        .environmentObject(model)
                }
            }
        }.navigationTitle("ViewModel In List")
    }
    
    
    struct ItemView: View {
        @EnvironmentObject var model: Model
        let item: Item
        @State private var updateFavourite = PassthroughSubject<Bool, Never>()
        @State private var favorite: Bool = false
        
        init(item: Item) {
            self.item = item
            self._favorite = State(initialValue: item.favorite)
        }
        
        var body: some View {
            print("ItemView \(item.index) refreshing"); return
            HStack {
                Text("index \(item.index)")
                Spacer()
                Image(systemName: favorite ? "heart.fill" : "heart")
                    .foregroundColor(favorite ? .red : .white)
                    .padding()
                    .onTapGesture {
                        favorite.toggle()
                        updateFavourite.send(favorite)
                    }
                    .onReceive(
                        updateFavourite
                            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//                            .removeDuplicates()
//                            .eraseToAnyPublisher()
                    ) { favorite in
                        print("set favorite as \(favorite)")
                        model.items[item.index].favorite = favorite
                    }
            }
            .frame(width: 200, height: 150)
            .background(Color.gray)
        }
    }
    
}
