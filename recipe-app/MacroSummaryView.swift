//
//  MacroSummaryView.swift
//  recipe-app
//
//  Created by Sphinx04 on 30.07.23.
//

import SwiftUI

struct MacroSummaryView: View {
    @ObservedObject var foodData: FoodData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HeaderView()
            
            HStack {
                Text("Total:")
                    .font(.title2)
                Spacer()
                Text(String(foodData.resultMacro().calories))
                    .foregroundColor(.red)
                    .frame(width: 50)
                Text(String(foodData.resultMacro().carbs))
                    .foregroundColor(.blue)
                    .frame(width: 30)
                Text(String(foodData.resultMacro().fats))
                    .foregroundColor(.orange)
                    .frame(width: 30)
                Text(String(foodData.resultMacro().proteins))
                    .foregroundColor(.brown)
                    .frame(width: 30)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(LinearGradient(colors: [.green.opacity(0.3), .orange.opacity(0.2)],
                                   startPoint: .topLeading, endPoint: .topTrailing)
            .overlay(.ultraThinMaterial)
        )
        .animation(Animation.easeInOut, value: 0.5)
    }
}

