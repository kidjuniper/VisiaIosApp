//
//  ScrollHelpers.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit

private extension UIScrollView {
    public var scrollsUp: Bool {
        panGestureRecognizer.velocity(in: nil).y < 0
    }
    
    public var scrollsDown: Bool {
        !scrollsUp
    }
    
    public var isContentOriginInBounds: Bool {
        contentOffset.y <= -adjustedContentInset.top + 20
    }
}
