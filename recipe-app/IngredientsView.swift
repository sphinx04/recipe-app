//
//  IngredientsView.swift
//  recipe-app
//
//  Created by Sphinx04 on 21.07.23.
//

import SwiftUI

struct IngredientsView: View {
    
    var body: some View {
        NavigationStack() {
            ZStack {
                CategirizedList()
            } //ZSTACK
            .navigationTitle("Ingredients")
            .safeAreaInset(edge: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        Text("Ingredients")
                            .font(.largeTitle.weight(.bold))
                            .padding(.horizontal)
                        Spacer()
                    }
                    HeaderView()
                }
                .padding()
                .background(LinearGradient(colors: [.green.opacity(0.3), .orange.opacity(0.2)],
                                           startPoint: .bottomLeading, endPoint: .bottomTrailing)
                    .overlay(.ultraThinMaterial)
                )
            }
            .navigationBarHidden(true)
        } //NAVIGATIONSTACK
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}

struct FoodItemView: View {
    let name: String
    let macros: (calories: Int, carbs: Int, fats: Int, proteins: Int)
    var body: some View {
        HStack {
            Text(name)
            Spacer()
            Text(String(macros.calories))
                .foregroundColor(.red)
                .frame(width: 50)
            Text(String(macros.carbs))
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(String(macros.fats))
                .foregroundColor(.orange)
                .frame(width: 30)
            Text(String(macros.proteins))
                .foregroundColor(.brown)
                .frame(width: 30)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Cal")
                .foregroundColor(.red)
                .frame(width: 50)
                .font(.system(size: 12))
            Text("Crb")
                .foregroundColor(.blue)
                .frame(width: 30)
                .font(.system(size: 12))
            Text("Fat")
                .foregroundColor(.orange)
                .frame(width: 30)
                .font(.system(size: 12))
            Text("Prt")
                .foregroundColor(.brown)
                .frame(width: 30)
                .font(.system(size: 12))
        }
        .fontWeight(.heavy)
        .frame(height: 20)
        .padding(.horizontal)
    }
}

struct CategirizedList: View {
    private var foodData = FoodData()
    
    var body: some View {
        ScrollView {
            ForEach(foodData.foodCategories.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Section {
                    ForEach(value.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        FoodItemView(name: key, macros: value)
                    }
                } header: {
                    HStack {
                        Text(key)
                            .padding(.top)
                            .padding(.horizontal, 20)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                } //SECTION
            } //FIRST FOREACH
        } //SCROLLVIEW
    }
}
