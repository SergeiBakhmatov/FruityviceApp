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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchFruits()
        print(fruits.count)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
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
