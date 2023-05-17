//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionId, environment in
            let halfOfWidth: NSCollectionLayoutDimension = .fractionalWidth(0.5)
            let width: NSCollectionLayoutDimension = .fractionalWidth(1)
            
            let itemSize = NSCollectionLayoutSize(widthDimension: halfOfWidth, heightDimension: width)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: halfOfWidth)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 20)
            
            return section
        }
    }
}
