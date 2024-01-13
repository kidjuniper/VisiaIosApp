//
//  TabViewController.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private enum Images {
        static let home = UIImage(systemName: "name")
        static let profile = UIImage(systemName: "name")
    }
    private enum TabBarItem: Int {
        case home
        case favourite
        case map
        case profile
        var iconName: String {
            switch self {
            case .home:
                return "house"
            case .favourite:
                return "heart"
            case .map:
                return "location"
            case .profile:
                return "person"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
        view.backgroundColor = .systemBackground
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.favourite,
                                        .home,
                                        .map,
                                        .profile]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .home:
                return ViewController()
            case .favourite:
                return ViewController()
            case .map:
                return MapViewController()
            case .profile:
                return ViewController()
            }
        }
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
 
        }
        self.selectedIndex = 2
        self.tabBar.tintColor = UIColor(named: "blueButtons")
        self.tabBar.layer.cornerRadius = 15
        self.tabBar.clipsToBounds = true
        self.tabBar.backgroundColor = .white
    }
    private func wrappedInNavigationController(with: UIViewController,
                                               title: Any?) -> UINavigationController {
        let controller = UINavigationController(rootViewController: with)
        return controller
    }
}
