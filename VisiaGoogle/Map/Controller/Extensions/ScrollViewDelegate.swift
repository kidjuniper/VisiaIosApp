//
//  ScrollViewDelegate.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 03.12.2023.
//

import Foundation
import UIKit

extension MapViewController: UIScrollViewDelegate {
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDragging = true
    }
    
    private func shouldDragOverlay(following scrollView: UIScrollView) -> Bool {
        guard scrollView.isTracking, isInteractiveTransitionCanBeHandled else {
            return false
        }
        return scrollView.isContentOriginInBounds && scrollView.scrollsDown
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset < 10 && scrollOffset > -0.2 {
            let previousTranslation = scrollViewTranslation
            scrollViewTranslation = scrollView.panGestureRecognizer.translation(in: scrollView).y
            
            didStartDragging = shouldDragOverlay(following: scrollView)
            if didStartDragging {
                startInteractiveTransitionIfNeeded(scrollView)
                overlayTranslation += scrollViewTranslation - previousTranslation
                
                updateInteractionControllerProgressPoints(verticalTranslation: overlayTranslation)
            } else {
                lastContentOffsetBeforeDragging = scrollView.panGestureRecognizer.translation(in: scrollView)
            }
        }
    }
    
    private func startInteractiveTransitionIfNeeded(_ scrollView: UIScrollView) {
        switch scrollView {
        case scroll:
            startInteractiveTransition()
        case pointsScrollView:
            startInteractiveTransitionPoints()
        default:
            return
        }
    }
    
    public func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView)
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset < 50 {
            switch scrollView {
            case scroll:
                if !(heightConstraint?.constant ?? 10000 < self.view.bounds.height * 0.9) {
                    endInteractiveTransition(
                        verticalVelocity: velocity.y,
                        verticalTranslation: translation.y - lastContentOffsetBeforeDragging.y
                    )
                }
            case pointsScrollView:
                endInteractiveTransitionPoints(
                    verticalVelocity: velocity.y,
                    verticalTranslation: translation.y - lastContentOffsetBeforeDragging.y
                )
            default:
                return
            }
            
            overlayTranslation = 0
            scrollViewTranslation = 0
            lastContentOffsetBeforeDragging = .zero
            didStartDragging = false
            isDragging = false
        }
    }
}

