//
//  Fruit.swift
//  FruityviceApp
//
//  Created by Sergei Bakhmatov on 09.05.2023.
//

struct Fruit: Decodable {
    
    let name: String
    let family: String
    let genus: String
    let order: String
    let nutritions: Nutrition
}

struct Nutrition: Decodable {
    let carbohydrates: Double
    let protein: Double
    let fat: Double
    let calories: Double
    let sugar: Double
}
