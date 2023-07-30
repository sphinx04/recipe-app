//
//  RecipeView.swift
//  recipe-app
//
//  Created by Sphinx04 on 22.07.23.
//

import SwiftUI

struct Ingredient: Hashable {
    let name: String
    var grams: Int
}

struct RecipeView: View {
    @ObservedObject var foodData = FoodData()
    @State private var showingAlert = false
    @State private var grams = 100
    @State private var currentIngredient = ""
    @State private var bottomBarVisible = false
    @State var searchSuggestionsVisible = true
    @State var searchText = ""
    @State var selectedCategory: String?
    
    @Environment(\.isSearching) var isSearching
    
    
    var filteredAllFoodData: [String: MacroTuple] {
        if searchText.isEmpty {
            return [:]
        } else {
            let result = foodData.allFoodDict.filter { $0.key.localizedCaseInsensitiveContains(searchText) }
            return result
        }
    }
    
    private func showAlert(key: String) {
            guard !foodData.ingredients.contains(where: { $0.name == key }) else { return }
            currentIngredient = key
            showingAlert.toggle()
            searchText = ""
            selectedCategory = nil
            grams = 100
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                
                RecipeTitleView()
                
                List {
                    Section {
                        ForEach(foodData.ingredients, id: \.self) { ingredient in
                            InRecipeListItemView(ingredient: ingredient) {
                                foodData.ingredients.removeAll(where: {$0 == ingredient })
                            }
                        }
                    }
                    .onSubmit(of: .search) {
                        selectedCategory = nil
                    }
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .alert(currentIngredient.capitalized, isPresented: $showingAlert) {
                TextField(currentIngredient.capitalized, value: $grams, format: .number)
                    .keyboardType(.numberPad)
                Button {
                    withAnimation {
                        foodData.ingredients.append(Ingredient(name: currentIngredient, grams: grams))
                    }
                } label: {
                    Text("Add")
                }
            } message: {
                Text("How many grams?")
            }
            .searchable(text: $searchText, prompt: "Search for ingredients") {
                if searchText.isEmpty {
                    if selectedCategory == nil {
                        ForEach(foodData.foodCategories.sorted(by: { $0.key < $1.key }), id: \.key) { key, _ in
                            
                            HStack {
                                Circle()
                                    .fill(Color.random().opacity(0.2))
                                    .frame(width: 50)
                                Text(key)
                                    .font(.title3)
                                
                                Spacer()
                            }
                            .onTapGesture {
                                selectedCategory = key
                            }
                        }
                        //FIRST FOREACH
                    }
                    else {
                        ForEach(foodData.foodCategories[selectedCategory!]!.sorted(by: { $0.key < $1.key }), id: \.key) { key, _ in
                            
                            SearchListItemView(name: key) {
                                showAlert(key: key)
                            }
                        } //FIRST FOREACH
                    }
                } else {
                    ForEach(filteredAllFoodData.sorted(by: { $0.key < $1.key }), id: \.key) { key, _ in
                        SearchListItemView(name: key) {
                            showAlert(key: key)
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .safeAreaInset(edge: .bottom) {
            if foodData.resultMacro() > (0,0,0,0) {
                MacroSummaryView(foodData: foodData)
            }
        }
    }
}

public extension Color {

    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
