//
//  MarketIconView.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation
import UIKit

class MarketIconView: UIImageView {
    private var iconView: UIImageView?
    private var iconImage: UIImage?
    
    override init(image: UIImage?) {
        super.init(image: UIImage(named: "MarkerIconBackgroundView"))
        iconImage = image
        
        guard let _ = image else {
            self.iconImage = UIImage(named: "Image")!
            return
        }
        iconView = UIImageView()
        iconView?.image = iconImage
        setAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        self.addSubview(iconView!)
        iconView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([iconView!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     iconView!.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.83),
                                     iconView!.heightAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.83),
                                     iconView!.topAnchor.constraint(equalTo: self.topAnchor,
                                                                    constant: self.bounds.width * 0.085)
        ])
        iconView?.clipsToBounds = true
        iconView?.layer.cornerRadius = 7
    }
}

class MarketIconViewClose: UIImageView {
    private var iconView: UIImageView?
    private var iconImage: UIImage?
    
    override init(image: UIImage?) {
        super.init(image: UIImage(named: "MarkerIconBackgroundViewClose"))
        iconImage = image
        
        guard let _ = image else {
            self.iconImage = UIImage(named: "Image")!
            return
        }
        iconView = UIImageView()
        iconView?.image = iconImage
        setAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAppearance() {
        self.addSubview(iconView!)
        iconView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([iconView!.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     iconView!.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.83),
                                     iconView!.heightAnchor.constraint(equalTo: self.widthAnchor,
                                                                      multiplier: 0.83),
                                     iconView!.topAnchor.constraint(equalTo: self.topAnchor,
                                                                    constant: self.bounds.width * 0.085)
        ])
        iconView?.clipsToBounds = true
        iconView?.layer.cornerRadius = 7
    }
}
