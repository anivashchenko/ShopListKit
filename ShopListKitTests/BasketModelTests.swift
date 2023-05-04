//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import XCTest
@testable import ShopListKit

final class BasketModelTests: XCTestCase {
            
    func test_init_arraysAreEmpty() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.sections.isEmpty)
    }
    
    func test_addNewItem_appendsNonExistedItem() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name")
        
        sut.addNewItem(addedAnyItem)
        
        XCTAssertEqual(sut.sections, [[addedAnyItem]])
    }
    
    func test_addNewItem_updatesExistedItemFromShopList() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name", count: 1)
        let doubleAddedAnyItem = addedItem(name: "any name", count: 2)
        
        sut.addNewItem(addedAnyItem)
        sut.addNewItem(addedAnyItem)

        XCTAssertEqual(sut.sections, [[doubleAddedAnyItem]])
    }
    
    func test_updateExistedItem_updatesExistedAddedItem() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name")
        let boughtAnyItem = boughtItem(name: "any name")
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        let addedAnotherItem = addedItem(name: "another name")
        
        sut.addNewItem(addedAnyItem)
        sut.addNewItem(addedAnotherItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)
        
        XCTAssertEqual(sut.sections, [[addedAnotherItem], [boughtAnyItem]])
    }

    func test_updateExistedItem_updatesExistedBoughtItem() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name")
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        let indexPathOfBoughtAnyItem = IndexPath(row: 0, section: 1)
        let addedAnotherItem = addedItem(name: "another name")
        
        sut.addNewItem(addedAnyItem)
        sut.addNewItem(addedAnotherItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)
        sut.updateExistedItem(at: indexPathOfBoughtAnyItem)
        
        XCTAssertEqual(sut.sections, [[addedAnotherItem, addedAnyItem]])
    }
    
    func test_updateExistedItem_sumsCountTwoBoughtItems() {
        let sut = makeSUT()
        let addedAnotherItem = addedItem(name: "another name", count: 1)
        let addedAnyItem = addedItem(name: "any name", count: 1)
        let indexPathOfAddedAnyItem = IndexPath(row: 1, section: 0)
        let doubleBoughtAnyItem = boughtItem(name: "any name", count: 2)
        
        sut.addNewItem(addedAnotherItem)
        sut.addNewItem(addedAnyItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)
        sut.addNewItem(addedAnyItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)

        XCTAssertEqual(sut.sections, [[addedAnotherItem], [doubleBoughtAnyItem]])
    }
    
    func test_updateExistedItem_sumsCountTwoAddedItems() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name", count: 1)
        let addedAnotherItem = addedItem(name: "another name", count: 1)
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        let indexPathOfBoughtAnyItem = IndexPath(row: 0, section: 1)
        let doubleAddedAnyItem = addedItem(name: "any name", count: 2)
        
        sut.addNewItem(addedAnyItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)
        sut.addNewItem(addedAnyItem)
        sut.addNewItem(addedAnotherItem)
        sut.updateExistedItem(at: indexPathOfBoughtAnyItem)
        
        XCTAssertEqual(sut.sections, [[doubleAddedAnyItem, addedAnotherItem]])
    }
    
    func test_moveRow_moveFirstItemToTheEnd() {
        let sut = makeSUT()
        let anyItem = addedItem(name: "any name")
        let anotherItem = addedItem(name: "another name")
        let indexPathOfAnyItemAtFirst = IndexPath(row: 0, section: 0)
        let indexPathOfAnyItemAtTheEnd = IndexPath(row: 1, section: 0)
        
        sut.addNewItem(anyItem)
        sut.addNewItem(anotherItem)
        sut.moveRow(from: indexPathOfAnyItemAtFirst, to: indexPathOfAnyItemAtTheEnd)
        
        XCTAssertEqual(sut.sections, [[anotherItem, anyItem]])
    }
    
    func test_removeAllItems() {
        let sut = makeSUT()
        let anyItem = addedItem(name: "any name")
        let anotherItem = addedItem(name: "another name")
        
        sut.addNewItem(anyItem)
        sut.addNewItem(anotherItem)
        sut.removeAllItems()
        
        XCTAssertTrue(sut.sections.isEmpty)
    }
    
    func test_removeItem_removesAnyItem() {
        let sut = makeSUT()
        let anyItem = addedItem(name: "any name")
        let anotherItem = addedItem(name: "another name")
        let indexPathOfAnyItem = IndexPath(row: 0, section: 0)
        
        sut.addNewItem(anyItem)
        sut.addNewItem(anotherItem)
        sut.removeItem(at: indexPathOfAnyItem)
        
        XCTAssertEqual(sut.sections, [[anotherItem]])
    }
    
    // MARK: - Helpers
    private func makeSUT() -> BasketModel {
        BasketModel()
    }
    
    private func addedItem(name: String, count: Int = 1) -> BasketItem {
        .init(name: name, countValue: count, typeFood: .berries)
    }
    
    private func boughtItem(name: String, count: Int = 1) -> BasketItem {
        .init(name: name, countValue: count, typeFood: .berries, isAddedToList: false, isBought: true)
    }
}
