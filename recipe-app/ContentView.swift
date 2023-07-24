//
//  ContentView.swift
//  recipe-app
//
//  Created by Sphinx04 on 20.07.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeView()
//        TabView {
//            mainPage()
//                .tabItem() {
//                    Image(systemName: "globe")
//                    Text("Main")
//                }
//
//            secondaryPage()
//                .tabItem() {
//                    Image(systemName: "person")
//                    Text("Personal")
//                }
//        }
    }
    
    private func mainPage() -> some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2)
                            Text("TEST")
                                .font(.largeTitle)
                                .fontWeight(.black)
                        }
                        .foregroundColor(.red)
                    } //HSTACK
                    .frame(height: 100)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                } //VSTACK
                
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button("Yes", action: {})
                        Button("No") {
                            print("No")
                        }
                    }
                    
                    
                    ToolbarItemGroup(placement: .secondaryAction) {
                        Button("Help", action: {})
                        Button("About", action: {})
                    }
                }
            } //SCROLLVIEW
        }
        
    }
    
    
    private func secondaryPage() -> some View {
        VStack {
            Image(systemName: "person")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, man!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
