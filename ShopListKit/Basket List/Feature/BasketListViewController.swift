//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit
import SwiftUI

class BasketListViewController: UITableViewController {

    var items: [BasketItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        let trashButton = UIBarButtonItem(image: UIImage(systemName: "trash.circle"), style: .plain, target: self, action: #selector(deleteAllItems))
        let topicButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(selectTopic))
        navigationItem.rightBarButtonItems = [topicButton, trashButton]
        
        fakeData()
        
        let nibName = UINib(nibName: BasketCell.reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BasketCell.reuseIdentifier)
    }

    @objc func deleteAllItems() {}
    @objc func selectTopic() {}
    
    private func fakeData() {
        let item1 = BasketItem(name: "Apple", countValue: 3, isAddedToList: true, isBought: false, isFavorite: false, typeFood: .fruits)
        let item2 = BasketItem(name: "Cherry", countValue: 1, isAddedToList: true, isBought: false, isFavorite: true, typeFood: .fruits)
        let item3 = BasketItem(name: "Cucumber", countValue: 1, isAddedToList: false, isBought: true, isFavorite: false, typeFood: .vegetables)
        let item4 = BasketItem(name: "Strawberry", countValue: 2, isAddedToList: false, isBought: true, isFavorite: false, typeFood: .fruits)
        items += [item1, item2, item3, item4]
    }

    private func configureStar(for cell: UITableViewCell, with item: BasketItem) {}
}

// MARK: - UITableViewDataSource
extension BasketListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as? BasketCell
        else { fatalError() }
        
        let item = items[indexPath.row]
        cell.itemImageView.image = UIImage(named: item.name)
        cell.titleLabel.attributedText = customTitleWithCount(
            title: item.name, count: item.countValue, size: 18, primaryColor: .white, secondaryColor: .lightGray)
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.starButton.tintColor = UIColor.systemYellow
        
            return cell
    }
}

// MARK: - UITableViewDelegate
extension BasketListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            var item = items[indexPath.row]
            item.isFavorite.toggle()
            configureStar(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        
        var title: String = ""
        switch section {
        case 0: title = "WANT TO BUY:"
        case 1: title = "BOUGHT:"
        default: break
        }
        
        let string = customAttributedTitle(title, size: 20, color: .darkGreen)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = 20
        string.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: string.length))
        
        label.attributedText = string
        
        return label
    }
}
