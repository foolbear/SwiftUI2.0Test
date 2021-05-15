//
//  MultiDownloadView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2021/5/14.
//

import SwiftUI
import Combine

// https://stackoverflow.com/a/32322851/12668737

struct MultiDownloadView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image).resizable().scaledToFit().frame(width: 300, height: 400, alignment: .center)
            }
            Button(action: { download() }, label: {
                Text("Download")
            })
        }.navigationBarTitle("MultiDownloadView")
    }
    
    func download() {
        viewModel.download()
        viewModel.test()
    }
    
    class ViewModel: ObservableObject {
        @Published var image: UIImage? = nil
        private var subscriptions: Set<AnyCancellable> = []
        
        func download() {
            // https://leonardo-matos.medium.com/using-combines-mergemany-to-fulfill-your-requests-99e652b89cbf
            // https://stackoverflow.com/a/58708381/12668737
            downloadsPublisher(for: urls)
                .receive(on: DispatchQueue.main)
                .map { ViewModel.merge(images: $0) }
                .compactMap { $0 }
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("done")
                    case .failure(let error):
                        print("failed", error)
                    }
                } receiveValue: { image in
                    self.image = image
                }
                .store(in: &subscriptions)
        }
        
        func downloadsPublisher(for urls: [URL]) -> AnyPublisher<[UIImage], Never> {
            Publishers.MergeMany(urls.compactMap { downloadPublisher(for: $0) })
                .compactMap { $0 }
                .collect()
                .eraseToAnyPublisher()
        }
        
        func downloadPublisher(for url: URL) -> AnyPublisher<UIImage?, Never> {
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .map { $0 as Data }
                .map { UIImage(data: $0) }
                .replaceError(with: nil)
                .eraseToAnyPublisher()
        }
        
        static func merge(images: [UIImage], isVertical: Bool = false) -> UIImage? {
            var width: CGFloat = 0, height: CGFloat = 0
            for image in images {
                let w = image.size.width, h = image.size.height
                if isVertical {
                    width = w > width ? w : width
                    height += h
                } else {
                    height = h > height ? h : height
                    width += w
                }
            }

            UIGraphicsBeginImageContext(CGSize(width: width, height: height))
            var posX: CGFloat = 0, posY: CGFloat = 0
            for image in images {
                image.draw(at: CGPoint(x: posX, y: posY))
                if isVertical {
                    posY += image.size.height
                } else {
                    posX += image.size.width
                }
            }
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return result
        }
    }
    
    // https://stackoverflow.com/a/59276234/12668737
    func test() {
        let myPublishers = [1,2,3]
            .map{ delayedPublisher($0, delay: 1 / Double($0)).print("\($0)").eraseToAnyPublisher() }
        
        Publishers.MergeMany(myPublishers)
            .collect()
            .sink { result in
                print("result:", result)
            }
            .store(in: &subscriptions)
    }
    
    func delayedPublisher<Value>(_ value: Value, delay after: Double) -> AnyPublisher<Value, Never> {
        let p = PassthroughSubject<Value, Never>()
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            p.send(value)
            p.send(completion: .finished)
        }
        return p.eraseToAnyPublisher()
    }
}

struct Slice: Codable {
    var index: Int32 = 0
    var sourceUrl: String = ""
}

let urls: [URL] = [
    URL(string: "https://www.mhnew.xyz//4/788/M6U113O9RBaegFITkpmEGw==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/rqCoC0TRnQamOuqEBb1A==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/a8E4s7ASJkuPY4t5krWQoA==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/I8XxEkDScgKehaR8ZVcwxw==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/GMxproDwUsgI+Q7D8IHGw==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/mj1dL6am4xGx6tD4LwC7kQ==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/TYUt0iY7oV9lBpjSg6Dlg==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/Fq0eRah+Bb+6apfryusqg==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/r7q2K0z29Sz+QK0fzyUImQ==.jpg")!,
    URL(string: "https://www.mhnew.xyz//4/788/kdvOMLEMPAWMdo4xeCfgVg==.jpg")!,
]

let slices: [Slice] = [
    Slice(index: 0, sourceUrl: "https://www.mhnew.xyz//4/788/M6U113O9RBaegFITkpmEGw==.jpg"),
    Slice(index: 1, sourceUrl: "https://www.mhnew.xyz//4/788/rqCoC0TRnQamOuqEBb1A==.jpg"),
    Slice(index: 2, sourceUrl: "https://www.mhnew.xyz//4/788/a8E4s7ASJkuPY4t5krWQoA==.jpg"),
    Slice(index: 3, sourceUrl: "https://www.mhnew.xyz//4/788/I8XxEkDScgKehaR8ZVcwxw==.jpg"),
    Slice(index: 4, sourceUrl: "https://www.mhnew.xyz//4/788/GMxproDwUsgI+Q7D8IHGw==.jpg"),
    Slice(index: 5, sourceUrl: "https://www.mhnew.xyz//4/788/mj1dL6am4xGx6tD4LwC7kQ==.jpg"),
    Slice(index: 6, sourceUrl: "https://www.mhnew.xyz//4/788/TYUt0iY7oV9lBpjSg6Dlg==.jpg"),
    Slice(index: 7, sourceUrl: "https://www.mhnew.xyz//4/788/Fq0eRah+Bb+6apfryusqg==.jpg"),
    Slice(index: 8, sourceUrl: "https://www.mhnew.xyz//4/788/r7q2K0z29Sz+QK0fzyUImQ==.jpg"),
    Slice(index: 9, sourceUrl: "https://www.mhnew.xyz//4/788/kdvOMLEMPAWMdo4xeCfgVg==.jpg"),
]


//"index": 11,
//            "sourceUrl": "https://www.mhnew.xyz/play?linkId=674033&bookId=1390429720578883584&key=iQetfcy/dO0i904cpk/gkw==",
//            "name": "第12话 是男人都抗拒不了的诱惑",
//            "pictures": [
//                {
//                    "index": 0,
//                    "slices": [
//                        {
//                            "index": 0,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/M6U113O9RBaegFITkpmEGw==.jpg"
//                        },
//                        {
//                            "index": 1,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/rqCoC0TRnQamOuqEBb1A==.jpg"
//                        },
//                        {
//                            "index": 2,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/a8E4s7ASJkuPY4t5krWQoA==.jpg"
//                        },
//                        {
//                            "index": 3,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/I8XxEkDScgKehaR8ZVcwxw==.jpg"
//                        },
//                        {
//                            "index": 4,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/GMxproDwUsgI+Q7D8IHGw==.jpg"
//                        },
//                        {
//                            "index": 5,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/mj1dL6am4xGx6tD4LwC7kQ==.jpg"
//                        },
//                        {
//                            "index": 6,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/TYUt0iY7oV9lBpjSg6Dlg==.jpg"
//                        },
//                        {
//                            "index": 7,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/Fq0eRah+Bb+6apfryusqg==.jpg"
//                        },
//                        {
//                            "index": 8,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/r7q2K0z29Sz+QK0fzyUImQ==.jpg"
//                        },
//                        {
//                            "index": 9,
//                            "sourceUrl": "https://www.mhnew.xyz//4/788/kdvOMLEMPAWMdo4xeCfgVg==.jpg"
//                        }
//                    ]
//                }

//struct MultiDownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiDownloadView()
//    }
//}
