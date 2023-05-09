//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import XCTest
@testable import ShopListKit

final class BasketModelUITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func test_onDelete_setsToInitialValues() {
        addAnyItem()
        removeAnyItem(from: app.tables)
        
        tapAnyItemInShopList()
        
        let countIsZero = app.staticTexts["0"]
        XCTAssertTrue(countIsZero.exists)
    }
    
    func test_onDeleteAllItems_setsToInitialValues() {
        addAnyItem()
        removeAllItems()
        
        tapAnyItemInShopList()
        
        let countIsZero = app.staticTexts["0"]
        XCTAssertTrue(countIsZero.exists)
    }
    
    func test_removeAllItems_showEmptyBasketView() {
        addAnyItem()

        removeAllItems()
        
        let emptyView = app.tables.images["EmptyBasketView"]
        XCTAssertTrue(emptyView.exists)
    }
    
    func test_removeItem_showEmptyBasketView() {
        let tables = app.tables
        addAnyItem()

        removeAnyItem(from: tables)

        let emptyView = tables.images["EmptyBasketView"]
        XCTAssertTrue(emptyView.exists)
    }
    
    func test_titleForHeader_wantToBuy() {
        addAnyItem()
        
        let wantToBuyTitle = app.tables.staticTexts["WANT TO BUY:"]
        XCTAssertTrue(wantToBuyTitle.exists)
    }
    
    func test_titleForHeader_bought() {
        let tables = app.tables
        addAnyItem()
        
        let firstCell = tables.cells.element(boundBy: 0)
        firstCell.tap()
        
        let boughtTitle = tables.staticTexts["BOUGHT:"]
        XCTAssertTrue(boughtTitle.exists)
    }
    
    // MARK: - Helpers
    private func addAnyItem() {
        let cell = app.collectionViews.cells.firstMatch
        cell.tap()
        
        let plusButton = app.buttons["+"]
        plusButton.tap()
        
        let addToBasketButton = app.buttons["AddToBasket"]
        addToBasketButton.tap()
        
        let basketTabBarButton = app.tabBars["Tab Bar"].buttons["Basket"]
        basketTabBarButton.tap()
    }
    
    private func removeAllItems() {
        let trashBarButton = app.buttons["TrashBarButton"]
        trashBarButton.tap()
        
        let alert = app.alerts.firstMatch
        let alertDeleteButton = alert.buttons["Delete"]
        alertDeleteButton.tap()
    }
    
    private func removeAnyItem(from tables: XCUIElementQuery) {
        let cell = tables.cells.element(boundBy: 0)
        cell.swipeLeft()
        
        let deleteButton = cell.buttons["Delete"]
        deleteButton.tap()
    }
    
    private func tapAnyItemInShopList() {
        let categoryTabBarButton = app.tabBars["Tab Bar"].buttons["Category"]
        categoryTabBarButton.tap()
        
        let cell = app.collectionViews.cells.firstMatch
        cell.tap()
    }
}
