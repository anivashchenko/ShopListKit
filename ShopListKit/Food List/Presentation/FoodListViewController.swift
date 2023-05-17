//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var groupTabView: GroupTabView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodModel: FoodModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The shop list"
        foodModel.loadItemsWhenAppear()
        setUpGroupTabView()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFoodAdd" {
            guard let controller = segue.destination as? FoodAddViewController else { return }
            controller.item = sender as? Item
            controller.foodModel = foodModel
        }
    }
    
    private func setUpGroupTabView() {
        let titles = foodModel.loadTabTitles()
        groupTabView.configureButtons(with: titles)
        
        groupTabView.onDidPressButton = { [weak self] title in
            self?.foodModel.filterCurrentItems(of: title.lowercased()) {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: FoodListViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FoodListViewCell.identifier)
        
        collectionView.collectionViewLayout = createCollectionViewLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension FoodListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodModel.currentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseId = FoodListViewCell.identifier
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? FoodListViewCell
        else { fatalError() }
        
        let item = foodModel.currentItems[indexPath.row]
        cell.imageView.image = UIImage(named: item.name)
        cell.label.attributedText = .customFoodListTitle(title: item.name, count: item.countValue)
        configureSystemCell(for: cell, item: item)
        cell.layer.backgroundColor = item.countValue == 0 ? .secondary : .veryLightGreen
        cell.layer.cornerRadius = 15
        
        return cell
    }
    
    private func configureSystemCell(for cell: FoodListViewCell, item: Item) {
        let configPlusIcon = UIImage.SymbolConfiguration(hierarchicalColor: .accentColor)
        let config = item.countValue == 0 ? configPlusIcon : nil
        let imageSystemName = item.countValue == 0 ? "plus.circle.fill" : "checkmark.circle.fill"
        cell.systemIcon.image = UIImage(systemName: imageSystemName, withConfiguration: config)
        cell.systemIcon.tintColor = item.countValue == 0 ? nil : UIColor(.yellow)
    }
}

// MARK: - UICollectionViewDelegate
extension FoodListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = foodModel.currentItems[indexPath.row]
        performSegue(withIdentifier: "ShowFoodAdd", sender: item)
    }
}
