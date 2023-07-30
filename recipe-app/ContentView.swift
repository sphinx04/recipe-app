//
//  ContentView.swift
//  recipe-app
//
//  Created by Sphinx04 on 20.07.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeView()
                .tabItem() {
                    Image(systemName: "sum")
                    Text("Calculator")
                }
            mainPage()
                .tabItem() {
                    Image(systemName: "globe")
                    Text("Main")
                }
            secondaryPage()
                .tabItem() {
                    Image(systemName: "person")
                    Text("Personal")
                }
        }
    }
    
    private func mainPage() -> some View {
        Text("Main Page")
    }
    
    
    private func secondaryPage() -> some View {
        Text("Personal")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
