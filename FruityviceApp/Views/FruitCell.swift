//
//  FruitCell.swift
//  FruityviceApp
//
//  Created by Sergei Bakhmatov on 09.05.2023.
//

import UIKit

final class FruitCell: UICollectionViewCell {
    
    @IBOutlet var fruitNameLabel: UILabel!
    @IBOutlet var fruitFamilyLabel: UILabel!
    @IBOutlet var fruitGenusLabel: UILabel!
    @IBOutlet var fruitOrderLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with fruit: Fruit) {
        
        fruitNameLabel.text = fruit.name
        fruitFamilyLabel.text = "Family: \(fruit.family)"
        fruitGenusLabel.text = "Genus: \(fruit.genus)"
        fruitOrderLabel.text = "Order: \(fruit.order)"
        
    }
    
    
}
