//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var tabBarController: UITabBarController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let basketModel = BasketModel()
        instantiateBasketListViewController(basketModel: basketModel)
        instantiateFoodListViewController(basketModel: basketModel)
    }
    
    private func instantiateBasketListViewController(basketModel: BasketModel) {
        let basketlistVC = instantiateViewController(indexOfVCInTheTabBar: 1) as? BasketListViewController
        basketlistVC?.basketModel = basketModel
        drawBasketIcon()
    }
    
    private func instantiateFoodListViewController(basketModel: BasketModel) {
        let dataLoader = JSONDataLoader()
        let foodModel = FoodListModel(items: dataLoader.loadData(), titles: dataLoader.titles, basketModel: basketModel)
        let foodlistVC = instantiateViewController(indexOfVCInTheTabBar: 0) as? FoodListViewController
        foodlistVC?.foodModel = foodModel
    }
    
    private func instantiateViewController(indexOfVCInTheTabBar: Int) -> UIViewController? {
        let navigationController = tabBarController?.viewControllers?[indexOfVCInTheTabBar] as? UINavigationController
        return navigationController?.viewControllers.first
    }
    
    private func drawBasketIcon() {
        let navigationController = tabBarController?.viewControllers?.last as? UINavigationController
        let basketImage = UIImage.basketIconImage(height: 30, color: .gray)
        navigationController?.tabBarItem = UITabBarItem(title: "Basket", image: basketImage, tag: 2)
    }
}
