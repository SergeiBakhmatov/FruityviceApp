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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredFruits: [Fruit] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSearchController()
        setupBackground(for: collectionView)
        fetchFruits()
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isFiltering ? filteredFruits.count : fruits.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fruitCell", for: indexPath)
        guard let cell = cell as? FruitCell else { return UICollectionViewCell() }
        let fruit = isFiltering
        ? filteredFruits[indexPath.item]
        : fruits[indexPath.item]
        
        cell.configure(with: fruit)
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fruit = isFiltering
        ? filteredFruits[indexPath.item]
        : fruits[indexPath.item]
        performSegue(withIdentifier: "showFruitInfo", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFruitInfo" {
            guard let fruitInfolVC = segue.destination as? FruitInfoViewController else { return }
            fruitInfolVC.fruit = fruit

        }
    }
    
    // MARK: Private Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
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

    // MARK: - UISearchResultsUpdating
extension FruitsCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredFruits = fruits.filter { fruit in
            return fruit.name.lowercased().contains(searchText.lowercased())
        }
        
        collectionView.reloadData()
    }
}
