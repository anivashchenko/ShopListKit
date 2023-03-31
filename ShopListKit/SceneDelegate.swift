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
        
        let dataLoader = JsonDataLoader()
        let foodModel = FoodModel(items: dataLoader.loadData(), titles: dataLoader.titles)
        
        let navigationController = tabBarController!.viewControllers![0] as? UINavigationController
        let controller = navigationController?.viewControllers[0] as? FoodListViewController
        controller?.foodModel = foodModel
        
        let basketNavigationController = tabBarController!.viewControllers![1] as? UINavigationController
        let basketController = basketNavigationController?.viewControllers[0] as? BasketListViewController
        basketController?.basketModel = BasketModel()
    }
}
