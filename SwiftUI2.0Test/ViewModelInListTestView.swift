//
//  ViewModelInListTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/3/29.
//

import SwiftUI
import Combine

struct Item {
    var index: Int
    var favorite: Bool
}

var items = [
    Item(index: 0, favorite: true),
    Item(index: 1, favorite: false),
    Item(index: 2, favorite: true),
    Item(index: 3, favorite: false),
    Item(index: 4, favorite: true),
    Item(index: 5, favorite: false),
    Item(index: 6, favorite: true),
    Item(index: 7, favorite: false),
    Item(index: 8, favorite: true),
    Item(index: 9, favorite: false),
    Item(index: 10, favorite: true),
    Item(index: 11, favorite: false),
    Item(index: 12, favorite: true),
    Item(index: 13, favorite: false),
    Item(index: 14, favorite: true),
    Item(index: 15, favorite: false),
    Item(index: 16, favorite: true),
    Item(index: 17, favorite: false),
    Item(index: 18, favorite: true),
    Item(index: 19, favorite: false),
]

struct ViewModelInListTestView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 4, alignment: .center)], spacing: 4) {
                ForEach(items, id: \.index) { item in
                    ItemView(item: item)
                }
            }
        }.navigationTitle("ViewModel In List")
    }
}

struct ItemView: View {
    let item: Item
    @ObservedObject var viewModel: ViewModel
    
    init(item: Item) {
        self.item = item
        self.viewModel = ViewModel(isFavorite: item.favorite)
    }
    
    var body: some View {
        HStack {
            Text("index \(item.index)")
            Spacer()
            Image(systemName: viewModel.isFavoriteI ? "heart.fill" : "heart")
                .foregroundColor(viewModel.isFavoriteI ? .red : .white)
                .padding()
                .onTapGesture { onFavoriteTapped() }
                .onChange(of: viewModel.isFavoriteO) { isFavorite in
                    setFavorite(isFavorite)
                }
        }
        .frame(width: 200, height: 150)
        .background(Color.gray)
    }
    
    func onFavoriteTapped() {
        viewModel.isFavoriteI.toggle()
    }
    
    func setFavorite(_ isFavorite: Bool) {
        print("\(item.index), isFavorite changed as \(isFavorite)")
        items[item.index].favorite = isFavorite
    }
    
    class ViewModel: ObservableObject {
        @Published var isFavoriteI: Bool = false
        @Published var isFavoriteO: Bool = false
        private var subscriptions: Set<AnyCancellable> = []
        
        init(isFavorite: Bool) {
            print("")
            isFavoriteI = isFavorite; isFavoriteO = isFavorite
            $isFavoriteI
                .dropFirst()
                .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
                .removeDuplicates()
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .assign(to: \.isFavoriteO, on: self)
                .store(in: &subscriptions)
        }
    }
}

struct ViewModelInList_Previews: PreviewProvider {
    static var previews: some View {
        ViewModelInListTestView()
    }
}
