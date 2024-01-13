//
//  InfoBottomSheetView.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit

final class BottomSheetView: UIView {
    public lazy var interactionImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "di"))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: 0,
                                 height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settings() {
        self.layer.cornerRadius = 25
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
}
