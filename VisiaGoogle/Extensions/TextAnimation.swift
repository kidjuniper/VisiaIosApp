//
//  TextAnimation.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 16.11.2023.
//

import Foundation
import UIKit

extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = newText
            self.fadeTransition(characterDelay)
        }
    }
}

extension UIView {
    // это анимация проявления
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: "kCATransitionFade")
    }
}
