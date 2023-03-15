//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import SwiftUI
import UIKit

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var groupView: GroupTab!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "The shop list"
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected, .highlighted:
                button.configuration = .customGroupButton
                button.configuration?.title = "Fruit"
            default:
                button.configuration = .customGroupSelectedButton
                button.configuration?.title = "Fruit"
            }
        }
        
        let buttons = [groupView.button1!, groupView.button2!, groupView.button3!]
        
        for button in buttons {
            button.configurationUpdateHandler = handler
            button.addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: ItemCollectionCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ItemCollectionCell.reuseIdentifier)
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionId, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
            
            return section
        })
        collectionView.collectionViewLayout = layout
        
        fakeData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFoodAdd" {
            let controller = segue.destination as! FoodAddViewController
            controller.item = sender as? Item
        }
    }
    
    private func fakeData() {
        let item1 = Item(name: "Apple", countValue: 3, isSet: false, isBought: false, typeFood: .fruits)
        let item2 = Item(name: "Cherry", countValue: 1, isSet: false, isBought: false, typeFood: .fruits)
        let item3 = Item(name: "Cucumber", countValue: 1, isSet: false, isBought: false, typeFood: .vegetables)
        let item4 = Item(name: "Strawberry", countValue: 2, isSet: false, isBought: false, typeFood: .berries)
        items += [item1, item2, item3, item4]
    }
    
    // MARK: - Actions
    @objc private func didTouchUpInside(sender: UIButton) {
        let buttons = [groupView.button1!, groupView.button2!, groupView.button3!]
        buttons.forEach({ $0.isSelected = ($0 == sender) })
    }
}

// MARK: - UICollectionViewDataSource
extension FoodListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionCell.reuseIdentifier, for: indexPath) as? ItemCollectionCell
        else { fatalError() }
        
        let item = items[indexPath.row]
        cell.imageView.image = UIImage(named: item.name)
        cell.label.text = item.name
        cell.layer.backgroundColor = CGColor.init(gray: 0.5, alpha: 0.2)
        cell.layer.cornerRadius = 20
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FoodListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        performSegue(withIdentifier: "ShowFoodAdd", sender: item)
    }
}
