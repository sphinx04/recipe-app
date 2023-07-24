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
    @State var searchText = ""
    private var foodData = FoodData()
    
    @State var ingredients = [Ingredient]()
    
    
    @State private var showingAlert = false
    @State private var grams = 100
    @State private var currentIngredient = ""
    @State private var bottomBarVisible = false
    
    //To model vvv
    
    private func resultMacro() -> MacroTuple {
        
        var result: MacroTuple = (0,0,0,0)
        
        
        for ingredient in ingredients {
            let ingredientMacro = foodData.allFoodDict[ingredient.name] ?? (0,0,0,0)
            
            let multiplier = Float(ingredient.grams) / 100.0
            
            result.calories += Int(Float(ingredientMacro.calories) * multiplier)
            result.carbs += Int(Float(ingredientMacro.carbs) * multiplier)
            result.fats += Int(Float(ingredientMacro.fats) * multiplier)
            result.proteins += Int(Float(ingredientMacro.proteins) * multiplier)
        }
        
        return result
    }
    
    
    var filteredAllFoodData: [String: MacroTuple] {
        if searchText.isEmpty {
            return [:]
        } else {
            return foodData.allFoodDict.filter { $0.key.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                
            Text("Choco moko loco")
                .font(.largeTitle)
            
            List {
                Section {
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            Text(ingredient.name)
                            
                            Spacer()
                            
                            Text("\(ingredient.grams) grams")
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                            
                            Button {
                                withAnimation {
                                    ingredients.removeAll(where: {$0 == ingredient })
                                }
                            } label: {
                                Image(systemName: "minus")
                            }
                        }
                        .swipeActions(allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                ingredients.removeAll(where: {$0 == ingredient })
                                
                            } label: {
                                Text("Delete")
                            }
                            .tint(.red)
                        }
                    }
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
                        ingredients.append(Ingredient(name: currentIngredient, grams: grams))
                    }
                } label: {
                    Text("Add")
                }
            } message: {
                Text("How many grams?")
            }
            .searchable(text: $searchText) {
                ForEach(filteredAllFoodData.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    HStack {
                        Text(key)
                        
                        Spacer()
                        
                        Button {
                            guard !ingredients.contains(where: { $0.name == key }) else { return }
                            currentIngredient = key
                            showingAlert.toggle()
                            searchText = ""
                            grams = 100
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .safeAreaInset(edge: .bottom) {
            if resultMacro() > (0,0,0,0) {
                VStack(alignment: .leading, spacing: 8) {
                    HeaderView()
                    
                    HStack {
                        Text("Total:")
                            .font(.title2)
                        Spacer()
                        Text(String(resultMacro().calories))
                            .foregroundColor(.red)
                            .frame(width: 50)
                        Text(String(resultMacro().carbs))
                            .foregroundColor(.blue)
                            .frame(width: 30)
                        Text(String(resultMacro().fats))
                            .foregroundColor(.orange)
                            .frame(width: 30)
                        Text(String(resultMacro().proteins))
                            .foregroundColor(.brown)
                            .frame(width: 30)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(LinearGradient(colors: [.green.opacity(0.3), .orange.opacity(0.2)],
                                           startPoint: .bottomLeading, endPoint: .bottomTrailing)
                    .overlay(.ultraThinMaterial)
                )
            }
        }
    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
