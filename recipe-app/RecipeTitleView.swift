//
//  RecipeTitleView.swift
//  recipe-app
//
//  Created by Sphinx04 on 30.07.23.
//

import Foundation
import SwiftUI

struct RecipeTitleView: View {
    @State var title = "Recipe"
    @State var showingAlert = false
    @State var newTitle = ""
    
    var body: some View {
        Text(title)
            .onTapGesture {
                showingAlert.toggle()
            }
            .font(.largeTitle)
            .alert("Rename", isPresented: $showingAlert) {
                TextField("Unnamed Recipe", text: $newTitle)
                Button {
                    withAnimation {
                        title = newTitle.isEmpty ? "Unnamed Recipe" : newTitle
                        newTitle = ""
                    }
                } label: {
                    Text("Rename")
                }
            } message: {
                Text("Enter new title:")
            }
            
    }
}
