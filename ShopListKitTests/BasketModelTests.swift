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
        let addedAnyItem = addedItem(name: "any name")
        let boughtAnyItem = boughtItem(name: "any name")
        let addedAnotherItem = addedItem(name: "another name")
        let indexPathOfAnyItemAtFirst = IndexPath(row: 0, section: 0)
        let indexPathOfAnyItemAtTheEnd = IndexPath(row: 1, section: 0)
        
        sut.addNewItem(addedAnyItem)
        sut.updateExistedItem(at: indexPathOfAnyItemAtFirst)
        sut.addNewItem(addedAnyItem)
        sut.addNewItem(addedAnotherItem)
        sut.moveRow(from: indexPathOfAnyItemAtFirst, to: indexPathOfAnyItemAtTheEnd)
        
        XCTAssertEqual(sut.sections, [[addedAnotherItem, addedAnyItem], [boughtAnyItem]])
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
    
    func test_removeItem_removesBoughtAnyItem() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name")
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        let indexPathOfBoughtAnyItem = IndexPath(row: 0, section: 1)
        
        sut.addNewItem(addedAnyItem)
        sut.updateExistedItem(at: indexPathOfAddedAnyItem)
        sut.addNewItem(addedAnyItem)
        sut.removeItem(at: indexPathOfBoughtAnyItem)
        
        XCTAssertEqual(sut.sections, [[addedAnyItem]])
    }
    
    func test_viewModelForItem_drawsAddedItem() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "Apple", count: 1)
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        
        sut.addNewItem(addedAnyItem)
        let vm = sut.viewModelForItem(at: indexPathOfAddedAnyItem)
        
        XCTAssertEqual(vm.image, UIImage(named: "Apple"))
        XCTAssertEqual(vm.attributedTitle.string, "Apple x1")
        XCTAssertEqual(vm.starImageColor, UIColor(.lightGray))
        XCTAssertEqual(vm.backgroundColor, UIColor(.darkGreen))
    }
    
    func test_viewModelForItem_drawsBoughtItem() {
        let sut = makeSUT()
        let boughtAnyItem = boughtItem(name: "any name", count: 1)
        let indexPathOfBoughtAnyItem = IndexPath(row: 0, section: 0)
        
        sut.addNewItem(boughtAnyItem)
        let vm = sut.viewModelForItem(at: indexPathOfBoughtAnyItem)
        
        let orangeCheckmark = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(UIColor(.customOrange))
        XCTAssertEqual(vm.image, orangeCheckmark)
        XCTAssertEqual(vm.attributedTitle.string, "any name x1")
        XCTAssertEqual(vm.starImageColor, UIColor(.lightGray))
        XCTAssertEqual(vm.backgroundColor, UIColor(.lightGreen))
    }
    
    func test_viewModelForItem_drawsYellowStar() {
        let sut = makeSUT()
        let addedAnyItem = addedItem(name: "any name", isFavorite: true)
        let indexPathOfAddedAnyItem = IndexPath(row: 0, section: 0)
        
        sut.addNewItem(addedAnyItem)
        let vm = sut.viewModelForItem(at: indexPathOfAddedAnyItem)
        
        XCTAssertEqual(vm.starImageColor, .systemYellow)
    }
    
    // MARK: - Helpers
    private func makeSUT() -> BasketModel {
        BasketModel()
    }
    
    private func addedItem(name: String, count: Int = 1, isFavorite: Bool = false) -> BasketItem {
        .init(name: name, countValue: count, typeFood: .berries, isFavorite: isFavorite)
    }
    
    private func boughtItem(name: String, count: Int = 1) -> BasketItem {
        .init(name: name, countValue: count, typeFood: .berries, isAddedToList: false, isBought: true)
    }
}
