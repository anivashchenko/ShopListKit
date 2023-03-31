//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit
import SwiftUI

class BasketListViewController: UITableViewController {

    var basketModel: BasketModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        let trashButton = UIBarButtonItem(image: UIImage(systemName: "trash.circle"), style: .plain, target: self, action: #selector(deleteAllItems))
        let topicButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(selectTopic))
        navigationItem.rightBarButtonItems = [topicButton, trashButton]
                
        let nibName = UINib(nibName: BasketCell.reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BasketCell.reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func deleteAllItems() {}
    @objc func selectTopic() {}
    
    private func configureStar(for cell: UITableViewCell, with item: BasketItem) {}
}

// MARK: - UITableViewDataSource
extension BasketListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketModel.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as? BasketCell
        else { fatalError() }
        
        let item = basketModel.items[indexPath.row]
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
            var item = basketModel.items[indexPath.row]
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
