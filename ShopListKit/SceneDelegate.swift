//
//  Copyright © 2023 Anastasia Ivashchenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateInitialViewController() as? UITabBarController
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        let basketModel = BasketModel()
        let basketNavController = tabBarController!.viewControllers![1] as? UINavigationController
        let basketViewController = basketNavController?.viewControllers[0] as? BasketListViewController
        basketViewController?.basketModel = basketModel
        drawBasketIcon(in: basketNavController)
        
        let dataLoader = JsonDataLoader()
        let foodModel = FoodListModel(items: dataLoader.loadData(), titles: dataLoader.titles, basketModel: basketModel)
        
        let navigationController = tabBarController!.viewControllers![0] as? UINavigationController
        let controller = navigationController?.viewControllers[0] as? FoodListViewController
        controller?.foodModel = foodModel
    }
    
    private func drawBasketIcon(in navigationController: UINavigationController?) {
        let basketImage = UIImage.imageFromBezierPath(
            .basketBezierPath(height: 30),
            size: CGSize(width: 30, height: 30),
            color: UIColor.gray.cgColor)
        navigationController?.tabBarItem = UITabBarItem(title: "Basket", image: basketImage, tag: 2)
    }
}
