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
    
    @objc func deleteAllItems() {
        showAlertBeforeDeleting() { [weak self] _ in
            self?.basketModel.removeAllItems()
            self?.tableView.reloadData()
        }
    }
    
    @objc func selectTopic() {}
    
    private func configureImage(for cell: BasketCell, with item: BasketItem) {
        let imageIsAdded = UIImage(named: item.name)
        let configIcon = UIImage.SymbolConfiguration(paletteColors: [UIColor(.customOrange)])
        let imageIsBought = UIImage(systemName: "checkmark.circle.fill", withConfiguration: configIcon)
        cell.itemImageView.image = item.isAddedToList ? imageIsAdded : imageIsBought
    }
    
    private func configureTitle(for cell: BasketCell, with item: BasketItem) {
        if item.isAddedToList {
            cell.titleLabel.attributedText = customTitleWithCount(
                title: item.name, count: item.countValue, size: 18,
                primaryColor: .white, secondaryColor: .lightGray)
        } else if item.isBought {
            cell.titleLabel.attributedText = customTitleWithCount(
                title: item.name, count: item.countValue, size: 18,
                primaryColor: .darkGray, secondaryColor: .gray)
        }
    }
    
    private func configureBackgroundColor(for cell: BasketCell, with item: BasketItem) {
        cell.backgroundColor = item.isAddedToList ? UIColor(.darkGreen) : UIColor(.lightGreen)
    }
    
    private func showAlertBeforeDeleting(handler: ((UIAlertAction) -> Void)?) {
        let title = "Do you want to remove the whole list?"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: handler)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension BasketListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? basketModel.addedItem.count : basketModel.boughtItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as? BasketCell
        else { fatalError() }
        
        let array = indexPath.section == 0 ? basketModel.addedItem : basketModel.boughtItem
        let item = array[indexPath.row]
        configureCell(cell, item: item)
        
        return cell
    }
    
    private func configureCell(_ cell: BasketCell, item: BasketItem) {
        configureImage(for: cell, with: item)
        configureTitle(for: cell, with: item)
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        cell.starButton.tintColor = UIColor.systemYellow
        configureBackgroundColor(for: cell, with: item)
    }
}

// MARK: - UITableViewDelegate
extension BasketListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BasketCell else { return }
        
        let currentItems = indexPath.section == 0 ? basketModel.addedItem : basketModel.boughtItem
        let item = currentItems[indexPath.row]
        configureImage(for: cell, with: item.updateIsBought())
        configureTitle(for: cell, with: item)
        configureBackgroundColor(for: cell, with: item.updateIsBought())
        basketModel.updateItem(item.updateIsBought())
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
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
        
        label.attributedText = customHeader(title: title, size: 20, color: .darkGreen)
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            basketModel.removeItem(at: indexPath)
            tableView.reloadData()
        }
    }
}
