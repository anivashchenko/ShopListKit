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
    
    func test_removeItem_showEmptyBasketView() {
        let tables = app.tables
        addAnyItem()

        let cell = tables.cells.element(boundBy: 0)
        cell.swipeLeft()
        let deleteButton = cell.buttons["Delete"]
        deleteButton.tap()

        let emptyView = tables.images["EmptyBasketView"]
        XCTAssertTrue(emptyView.exists)
    }
    
    // MARK: - Helpers
    private func addAnyItem() {
        let cell = app.collectionViews.cells.firstMatch
        cell.tap()
        
        let plusButton = app.buttons["+"]
        plusButton.tap()
        
        let addToBasketButton = app.buttons["AddToBasket"]
        addToBasketButton.tap()
        
        let basketTabBarButton = self.app.tabBars["Tab Bar"].buttons["Basket"]
        basketTabBarButton.tap()
    }
}
