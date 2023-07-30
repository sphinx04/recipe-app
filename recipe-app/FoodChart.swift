//
//  FoodChart.swift
//  recipe-app
//
//  Created by Sphinx04 on 21.07.23.
//

import Foundation

typealias MacroTuple = (calories: Int, carbs: Int, fats: Int, proteins: Int)

final class FoodData: ObservableObject {
    
    @Published var foodCategories: [String: [String: MacroTuple]] = [:]
    @Published var allFoodDict: [String: MacroTuple] = [:]
    @Published var ingredients = [Ingredient]()
    
    init() {
        fillFoodCategories()
        
        for dict in foodCategories {
            allFoodDict.merge(dict.value) { curr, _ in
                curr
            }
        }
        
    }
    
    func resultMacro() -> MacroTuple {
        
        var result: MacroTuple = (0,0,0,0)
        
        
        for ingredient in ingredients {
            let ingredientMacro = allFoodDict[ingredient.name] ?? (0,0,0,0)
            
            let multiplier = Float(ingredient.grams) / 100.0
            
            result.calories += Int(Float(ingredientMacro.calories) * multiplier)
            result.carbs += Int(Float(ingredientMacro.carbs) * multiplier)
            result.fats += Int(Float(ingredientMacro.fats) * multiplier)
            result.proteins += Int(Float(ingredientMacro.proteins) * multiplier)
        }
        
        return result
    }
    
    private func fillFoodCategories() {
        // Add foods and their macros to the dictionaries based on categories
        // Fruits
        foodCategories["Fruits"] = [
            "Apple": (52, 14, 0, 0),
            "Banana": (96, 23, 0, 1),
            "Orange": (43, 9, 0, 1),
            "Strawberries": (32, 8, 0, 1),
            "Watermelon": (30, 8, 0, 1),
            "Mango": (60, 15, 0, 1),
            "Pineapple": (50, 13, 0, 1),
            "Grapes": (69, 18, 0, 1),
            "Blueberries": (57, 14, 0, 1),
            "Kiwi": (61, 15, 0, 1),
            "Peach": (39, 9, 0, 1),
            "Plum": (46, 11, 0, 1),
            "Cherries": (63, 16, 0, 1),
            "Pear": (57, 15, 0, 0),
            "Raspberry": (52, 12, 0, 1),
            "Blackberry": (43, 9, 0, 1),
            "Apricot": (15, 3, 0, 1),
            "Cantaloupe": (34, 8, 0, 1),
            "Honeydew Melon": (36, 9, 0, 0),
            "Grapefruit": (42, 11, 0, 1),
            // Add more fruits as needed
            // ...
        ]
        
        // Proteins
        foodCategories["Proteins"] = [
            "Chicken Breast": (165, 0, 3, 31),
            "Salmon": (208, 0, 13, 20),
            "Eggs": (143, 1, 10, 13),
            "Tuna (canned in water)": (116, 0, 1, 27),
            "Lentils (cooked)": (116, 20, 0, 9),
            "Beef (lean)": (250, 0, 15, 27),
            "Turkey Breast": (135, 0, 2, 29),
            "Shrimp": (85, 0, 1, 18),
            "Tofu": (76, 2, 4, 8),
            "Cottage Cheese": (98, 3, 4, 11),
            // Add more proteins as needed
            // ...
        ]
        
        // Grains
        foodCategories["Grains"] = [
            "Rice (cooked)": (130, 28, 0, 3),
            "Pasta (cooked)": (131, 25, 1, 5),
            "Quinoa (cooked)": (120, 21, 2, 4),
            "Oats": (389, 66, 7, 17),
            "Brown Rice (cooked)": (111, 23, 1, 3),
            "Barley (cooked)": (123, 28, 0, 3),
            "Buckwheat (cooked)": (92, 20, 1, 3),
            "Couscous (cooked)": (112, 23, 0, 4),
            "Bulgur (cooked)": (83, 18, 0, 3),
            "Farro (cooked)": (170, 34, 1, 7),
            // Add more grains as needed
            // ...
        ]
        
        // Vegetables
        foodCategories["Vegetables"] = [
            "Broccoli": (34, 7, 0, 3),
            "Carrots": (41, 10, 0, 1),
            "Spinach": (23, 4, 0, 3),
            "Tomato": (18, 3, 0, 1),
            "Cucumber": (15, 4, 0, 1),
            "Lettuce": (15, 2, 0, 1),
            "Bell Pepper": (31, 6, 0, 1),
            "Cauliflower": (25, 5, 0, 2),
            "Zucchini": (17, 3, 0, 1),
            "Asparagus": (20, 4, 0, 2),
            // Add more vegetables as needed
            // ...
        ]
        
        // Dairy Products
        foodCategories["Dairy Products"] = [
            "Milk (whole)": (61, 5, 3, 3),
            "Greek Yogurt": (59, 3, 1, 10),
            "Cheddar Cheese": (403, 1, 33, 25),
            "Cottage Cheese": (98, 3, 4, 11),
            "Butter": (717, 0, 81, 0),
            "Sour Cream": (198, 5, 20, 2),
            "Cream Cheese": (349, 4, 35, 6),
            "Yogurt (low-fat)": (63, 10, 2, 4),
            // Add more dairy products as needed
        ]
        
        // Nuts and Seeds
        foodCategories["Nuts and Seeds"] = [
            "Almonds": (579, 21, 49, 21),
            "Peanuts": (567, 16, 49, 26),
            "Walnuts": (654, 14, 65, 15),
            "Cashews": (553, 30, 44, 18),
            "Pistachios": (562, 28, 45, 20),
            "Sunflower Seeds": (584, 20, 51, 21),
            "Pumpkin Seeds": (559, 15, 49, 30),
            "Chia Seeds": (486, 42, 31, 16),
            // Add more nuts and seeds as needed
        ]
        
        // Desserts
        foodCategories["Desserts"] = [
            "Chocolate Chip Cookie": (502, 67, 24, 6),
            "Brownie": (466, 68, 21, 5),
            "Ice Cream (vanilla)": (207, 26, 11, 3),
            "Cheesecake": (321, 31, 20, 5),
            "Cupcake": (369, 51, 17, 4),
            "Chocolate Cake": (367, 51, 16, 4),
            "Fruit Tart": (367, 44, 19, 7),
            "Donut": (452, 49, 24, 6),
            // Add more dessert items as needed
        ]
    }
}
