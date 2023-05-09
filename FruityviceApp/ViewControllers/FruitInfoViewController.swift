//
//  FruitInfoViewController.swift
//  FruityviceApp
//
//  Created by Sergei Bakhmatov on 09.05.2023.
//

import UIKit

final class FruitInfoViewController: UIViewController {
    
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var fatLabel: UILabel!
    @IBOutlet var sugarLabel: UILabel!
    @IBOutlet var carbohydratesLabel: UILabel!
    @IBOutlet var proteinLabel: UILabel!
    
    var fruit: Fruit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(fruit.name) nutrition:"
        caloriesLabel.text = "Calories: \(fruit.nutritions.calories)"
        fatLabel.text = "Fat: \(fruit.nutritions.fat)"
        sugarLabel.text = "Sugar: \(fruit.nutritions.sugar)"
        carbohydratesLabel.text = "Carbohydrates: \(fruit.nutritions.carbohydrates)"
        proteinLabel.text = "Protein: \(fruit.nutritions.protein)"

    }
}
