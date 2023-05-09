//
//  FruitsCollectionViewController.swift
//  FruityviceApp
//
//  Created by Sergei Bakhmatov on 09.05.2023.
//

import UIKit

final class FruitsCollectionViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager.shared
    private var fruits: [Fruit] = []
    private var fruit: Fruit?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFruits()
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fruits.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fruitCell", for: indexPath)
        guard let cell = cell as? FruitCell else { return UICollectionViewCell() }
        let fruit = fruits[indexPath.item]
        
        cell.configure(with: fruit)
    
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFruitInfo" {
            guard let fruitInfolVC = segue.destination as? FruitInfoViewController else { return }
            fruitInfolVC.fruit = fruit

        }
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fruit = fruits[indexPath.row]
        performSegue(withIdentifier: "showFruitInfo", sender: self)
    }

}
    //MARK: Networking
extension FruitsCollectionViewController {
    
    private func fetchFruits() {
        networkManager.fetch(
            [Fruit].self,
            from: URL(string: "https://www.fruityvice.com/api/fruit/all")!) { [weak self] result in
                switch result {
                case .success(let fruits):
                    self?.fruits = fruits
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
