//
//  BorderLine.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit

class Border: UIImageView {
    required override init(image: UIImage?) {
        super.init(image: UIImage(named: "line"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
