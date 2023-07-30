//
//  InRecipeListItemView.swift
//  recipe-app
//
//  Created by Sphinx04 on 30.07.23.
//

import Foundation
import SwiftUI

struct InRecipeListItemView: View {
    let ingredient: Ingredient
    var action: () -> ()
    
    var body: some View {
        HStack {
            Text(ingredient.name)
            
            Spacer()
            
            Text("\(ingredient.grams) grams")
                .multilineTextAlignment(.trailing)
                .frame(width: 100)
            
            Button {
                withAnimation {
                    action()
                }
            } label: {
                Image(systemName: "minus")
            }
        }
        .swipeActions(allowsFullSwipe: true) {
            Button("Remove", role: .destructive, action: action)
                .tint(.red)
        }
    }
}
