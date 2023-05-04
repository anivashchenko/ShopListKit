//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit
import SwiftUI

class BasketListViewController: UITableViewController {
    
    var basketModel: BasketModel!
    let emptyView = EmptyBasketView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash.circle"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(deleteAllItems))
        
        let nibName = UINib(nibName: BasketCell.reuseIdentifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: BasketCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureEmptyView()
        tableView.reloadData()
    }
    
    @objc func deleteAllItems() {
        showAlertBeforeDeleting() { [weak self] _ in
            self?.basketModel.removeAllItems()
            self?.configureEmptyView()
            self?.tableView.reloadData()
        }
    }
    
    private func configureEmptyView() {
        emptyView.frame = view.frame
        let basketIsEmpty = basketModel.addedItem.isEmpty && basketModel.boughtItem.isEmpty
        basketIsEmpty ? view.addSubview(emptyView) : emptyView.removeFromSuperview()
        navigationController?.navigationBar.isHidden = basketIsEmpty
        tableView.contentInsetAdjustmentBehavior = basketIsEmpty ? .never : .automatic
        tableView.isScrollEnabled = !basketIsEmpty
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
        basketModel.sections.reduce(0) { $0 + (!$1.isEmpty ? 1 : 0) }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketModel.sections[basketModel.addedItem.isEmpty ? section + 1 : section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.reuseIdentifier, for: indexPath) as! BasketCell
        cell.viewModel = basketModel.viewModelForItem(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            basketModel.removeItem(at: indexPath)
            configureEmptyView()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        basketModel.moveRow(from: sourceIndexPath, to: destinationIndexPath)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension BasketListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BasketCell else { return }
        
        basketModel.updateExistedItem(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        let title = basketModel.currentTitle(from: ["WANT TO BUY:", "BOUGHT:"], at: section)
        label.attributedText = customHeader(title: title, size: 20, color: .darkGreen)
        
        return label
    }
}
