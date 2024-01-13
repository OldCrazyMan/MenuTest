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
            generateNavigationController(rootViewController: firstVC, title: "Меню", image: "fork.knife"),
            generateNavigationController(rootViewController: secondVC, title: "Контакты",  image: "figure.2"),
            generateNavigationController(rootViewController: thirdVC, title: "Профиль", image: "person"),
            generateNavigationController(rootViewController: fourthVC, title: "Корзина", image: "basket")
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        return navigationVC
    }
}
