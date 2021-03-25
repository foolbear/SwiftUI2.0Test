//
//  ContentView.swift
//  SwiftUI2.0Test
//
//  Created by foolbear on 2020/11/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: PreferenceKeyTestView()) {
                        Text("PreferenceKey Test")
                    }
                    NavigationLink(destination: FontTestView()) {
                        Text("Font")
                    }
                    NavigationLink(destination: AnimationTestView()) {
                        Text("Animation Test")
                    }
                    NavigationLink(destination: NavigationTestView()) {
                        Text("Navigation Test")
                    }
                    NavigationLink(destination: DarkModeTestView()) {
                        Text("Dark Mode Test")
                    }
                    NavigationLink(destination: SignInWithAppleTestView()) {
                        Text("Sign In With Apple Test")
                    }
                    NavigationLink(destination: CloudKitTestView()) {
                        Text("CloudKit Test")
                    }
                    NavigationLink(destination: ShadowTestView()) {
                        Text("Shadow Test")
                    }
                }
                Section {
                    NavigationLink(destination: ScrollViewAndLazyVStackTestView()) {
                        Text("Scroll View And LazyVStack")
                    }
                    NavigationLink(destination: ProgressViewTestView()) {
                        Text("Progress View")
                    }
                    NavigationLink(destination: LabelAndLinkTestView()) {
                        Text("Label And Link")
                    }
                    NavigationLink(destination: ColorPickerTestView()) {
                        Text("Color Picker")
                    }
                    NavigationLink(destination: TextEditorTestView()) {
                        Text("Text Editor")
                    }
                    NavigationLink(destination: OnChangeTestView()) {
                        Text("onChange")
                    }
                    NavigationLink(destination: TabViewTestView()) {
                        Text("Tab View")
                    }
                    NavigationLink(destination: LazyVGridTestView()) {
                        Text("LazyVGrid")
                    }
                    NavigationLink(destination: MapTestView()) {
                        Text("Map")
                    }
                    NavigationLink(destination: RequestMoreTestView()) {
                        Text("Request More")
                    }
                }
                Section {
                    NavigationLink(destination: MenuTestView()) {
                        Text("Menu")
                    }
                    NavigationLink(destination: SheetTestView()) {
                        Text("Sheet")
                    }
                    NavigationLink(destination: TextFieldTestView()) {
                        Text("Text Field")
                    }
                    NavigationLink(destination: DisclosureGroupTestView()) {
                        Text("Disclosure Group")
                    }
                    NavigationLink(destination: VideoPlayerTestView()) {
                        Text("Video Player")
                    }
                    NavigationLink(destination: ListChildrenTestView()) {
                        Text("List Children")
                    }
                    NavigationLink(destination: AppStoreOverlayTestView()) {
                        Text("AppStore Overlay")
                    }
                    NavigationLink(destination: DatePickerTestView()) {
                        Text("Date Picker")
                    }
                    NavigationLink(destination: MatchedGeometryEffectTestView()) {
                        Text("MatchedGeometryEffect")
                    }
                    NavigationLink(destination: PickerTestView()) {
                        Text("Picker")
                    }
                }
            }
            .navigationBarTitle("SwiftUI 2.0 Test")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
