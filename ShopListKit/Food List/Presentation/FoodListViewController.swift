//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var groupView: GroupTab!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodModel: FoodModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The shop list"
        foodModel.loadItemsWhenAppear()
        loadGroupTabView()
        loadItemCollectionCellView(from: collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
    }
    
    private func loadGroupTabView() {
        groupView.button1.isSelected = true
        let buttons = [groupView.button1!, groupView.button2!, groupView.button3!]
        for button in buttons {
            button.configurationUpdateHandler = getConfigurationHandler(for: buttons)
            button.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        }
    }
    
    private func loadItemCollectionCellView(from collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: ItemCollectionCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ItemCollectionCell.reuseIdentifier)
        
        collectionView.collectionViewLayout = getCollectionViewCompositionalLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFoodAdd" {
            let controller = segue.destination as! FoodAddViewController
            controller.item = sender as? Item
            controller.foodModel = foodModel
        }
    }
    
    // MARK: - Actions
    @objc private func didTouchUpInside(sender: UIButton) {
        let buttons = [groupView.button1!, groupView.button2!, groupView.button3!]
        buttons.forEach({ $0.isSelected = ($0 == sender) })
        
        guard let title = sender.titleLabel?.text else { return }
        
        foodModel.filterCurrentItems(of: title.lowercased()) {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    private func getConfigurationHandler(for buttons: [UIButton]) -> UIButton.ConfigurationUpdateHandler {
        let titles = foodModel.loadTabTitles()
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            guard titles.count == buttons.count,
                  let index = buttons.firstIndex(where: { $0 == button })
            else { return }
            
            switch button.state {
            case .selected, .highlighted:
                button.configuration = .customGroupButton(text: titles[index], font: .body)
            default:
                button.configuration = .customGroupSelectedButton(text: titles[index], font: .body)
            }
        }
        
        return handler
    }
    
    private func getCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionId, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
            
            return section
        })
    }
}

// MARK: - UICollectionViewDataSource
extension FoodListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodModel.currentItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionCell.reuseIdentifier, for: indexPath) as? ItemCollectionCell
        else { fatalError() }
        
        let item = foodModel.currentItems[indexPath.row]
        cell.imageView.image = UIImage(named: item.name)
        cell.label.attributedText = customCellTitle(title: item.name, count: item.countValue)
        configureSystemCell(for: cell, item: item)
        cell.layer.backgroundColor = UIColor(item.countValue == 0 ? .secondary : .veryLightGreen).cgColor
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    private func configureSystemCell(for cell: ItemCollectionCell, item: Item) {
        let configForAddedItem = UIImage.SymbolConfiguration(hierarchicalColor: UIColor(.darkGreen))
        let config = item.countValue == 0 ? configForAddedItem : nil
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
