//
//  StartAnimationViewController.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import UIKit

final class StartAnimationViewController: UIViewController {
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        let logoImage = UIImage(named: "lauchScreenLogo")
        logo.image = logoImage
        return logo
    }()
    
    private lazy var logolabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura Bold",
                            size: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor(named: "blueButtons")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appearanceSetting()
        presentMainScreen()
    }
    
    func appearanceSetting() {
        // MARK: view settings
        view.backgroundColor = .systemBackground
        // MARK: subViews settings
        [logo, logolabel].forEach {
            view.addSubview($0 as UIView)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                          constant: 90),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                          constant: -90),
            logo.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 311),
            logo.bottomAnchor.constraint(equalTo:  view.bottomAnchor,
                                              constant: -441),
            
            logolabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 49),
            logolabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -49),
            logolabel.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: 423),
            logolabel.bottomAnchor.constraint(equalTo:  view.bottomAnchor,
                                              constant: -363)
        ])
        
        logolabel.animate(newText: """
    Добро пожаловать в
    Vizia!
    """,
                          characterDelay: 1)
    }
    
    // MARK: func to present navigation controller
    func presentMainScreen() {
        let mainScreen = TabBarController()
        mainScreen.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(mainScreen,
                         animated: true)
        }
    }
}
