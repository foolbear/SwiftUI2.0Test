//
//  MapTestView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/3.
//

import SwiftUI
import MapKit

struct MapTestView: View {
    //设置初始显示区域
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.92083, longitude: 121.63917), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    //设置是否持续跟踪用户当前位置
    @State private var trackmode = MapUserTrackingMode.follow
    
    //设置标记点信息
    let dots: [MapDot] = [MapDot(title:"point1", coordinate:CLLocationCoordinate2D(latitude: 38.92083, longitude: 121.63917), color:.red), MapDot(title:"point2", coordinate:CLLocationCoordinate2D(latitude: 38.92183, longitude: 121.62717), color:.blue)]
    
    @StateObject var store = Store()
    
    var body: some View {
        ZStack(alignment:.bottom){
            Map(coordinateRegion: $region,
                interactionModes: .all, //.pan .zoom .all
                showsUserLocation: true, //是否显示用户当前位置
                userTrackingMode: $trackmode, //是否更新用户位置
                annotationItems: dots //标记点数据
            ){ item in
                //标记点显示,也可以直接使用内置的MapPin,不过MapPin无法响应用户输入
                MapAnnotation(coordinate: item.coordinate  ){
                    //不知道是否是bug,目前iOS下无法显示Text,maxOS可以显示
                    Label(item.title, systemImage: "star.fill")
                        .font(.body)
                        .foregroundColor(item.color)
                        .onTapGesture {
                            print(item.title)
                        }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Map")
    }
}

//标记点数据,要求符合Identifiable
struct MapDot: Identifiable{
    let id = UUID()
    let title:String
    let coordinate:CLLocationCoordinate2D
    let color:Color
}

class Store: ObservableObject {
    let manager = CLLocationManager()
    init() {
        //请求位置访问权限.需要在plist中设置 Privacy - Location When In Use Usage Description
        //如果不需要显示当前用户位置,则无需申请权限
        #if os(iOS)
        manager.requestWhenInUseAuthorization()
        #endif
    }
}

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView()
    }
}
