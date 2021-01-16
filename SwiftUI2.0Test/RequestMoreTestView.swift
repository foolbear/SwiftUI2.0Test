//
//  RequestMoreTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI

struct RequestMoreTestView: View {
    
    @State var list = (1...40).map{ $0 }
    @State var loading = false
    
    var body: some View {
        VStack{
            Text("count:\(list.count)")
            //数据数量，在LazyVStack下数据在每次刷新后才会增加，在VStack下，数据会一直增加。
            ScrollView{
                LazyVStack{ //换成VStack作比较
                    ForEach(list, id:\.self) { item in
                        Text("\(item)")
                            .onAppear {
                                //如果是最后一个数据则获取新数据
                                if item == list.last! && loading != true {
                                    requestMore()
                                }
                            }
                    }
                }
                if loading {
                    ProgressView()
                }
            }
        }.navigationBarTitle("Rquest More")
    }
    
    func requestMore(){
        loading = true
        //增加延时，模拟异步数据获取效果
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            //数据模拟，也可获取网络数据
            let last = list.last! + 1
            list.append(contentsOf: (last..<last+40).map{ $0 })
            loading = false
        }
    }
}

struct RequestMoreTestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestMoreTestView()
    }
}
