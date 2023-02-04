//
//  ContentView.swift
//  NavigationStack+TabView
//
//  Created by July universe on 2023/02/04.
//

import SwiftUI

struct ContentView: View {
    // view를 push 및 pop 할 수 있는 위치
    @State var mainStack: [NavigationType] = []
    
    var body: some View {
        NavigationStack(path: $mainStack) {
            // TabView가 있는 complex structure(복잡한 구조)
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                Text("Liked")
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                Text("Settings")
                    .tabItem {
                        Image(systemName: "person.circle.fill")
                    }
            }
            .navigationTitle("Instagram")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // 간단히 새 view를 푸시
                        mainStack.append(.camera)
                    } label: {
                        Image(systemName: "camera")
                            .font(.callout)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // 간단히 새 view를 푸시
                        mainStack.append(.dm)
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.callout)
                    }
                }
            }
            // 데이터 유형을 기반으로 새 API를 푸시할 수 있다.
            .navigationDestination(for: NavigationType.self) { value in
                switch value {
                case .home: Text("Home")
                case .camera: VStack {
                    Text("Camera view")
                    // Pop view는 간단하다.
                    // 그냥 stack에서 removeLast() 또는 이동하려는 view를 설정하면 된다.
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    // Camera view로 이동
                    Button("Go to Camera view") {
                        mainStack.append(.camera)
                    }
                    // DM view로 이동
                    Button("Go to DM view") {
                        mainStack.append(.dm)
                    }
                }
                case .dm: VStack {
                    Text("DM view")
                    // Pop view는 간단하다.
                    // 그냥 stack에서 removeLast() 또는 이동하려는 view를 설정하면 된다.
                    Button("Pop") {
                        mainStack.removeLast()
                    }
                    // Camera view로 이동
                    Button("Go to Camera view") {
                        mainStack.append(.camera)
                    }
                    // root view로 이동
                    Button("Pop to root") {
                        mainStack.removeAll()
                    }
                }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// NavigationStack item들의 enum case
enum NavigationType: String, Hashable {
    case home = "HOME"
    case camera = "CAMERA VIEW"
    case dm = "DM VIEW"
}
