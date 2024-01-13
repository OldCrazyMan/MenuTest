//
//  MainTabBarController.swift
//  HammerMenuTest
//
//  Created by Tim Akhmetov on 12.01.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTapBar()
        setupViewControllers()
    }
    
    private func setupTapBar() {
        view.backgroundColor = .white
        
        tabBar.tintColor = .red
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setupViewControllers() {
        let firstVC = ModelBuilder.createMainModule()
        let secondVC = ContactsViewController()
        let thirdVC = ThirdViewController()
        let fourthVC = FourthViewController()
        
        viewControllers = [
            generateNavigationController(rootViewController: firstVC, image: #imageLiteral(resourceName: "Меню")),
            generateNavigationController(rootViewController: secondVC,  image: #imageLiteral(resourceName: "Контакты")),
            generateNavigationController(rootViewController: thirdVC, image: #imageLiteral(resourceName: "Профиль")),
            generateNavigationController(rootViewController: fourthVC, image: #imageLiteral(resourceName: "Корзина"))
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
