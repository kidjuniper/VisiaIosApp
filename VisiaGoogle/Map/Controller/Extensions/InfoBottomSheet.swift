//
//  InfoBottomSheet.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 02.12.2023.
//

import Foundation
import UIKit

extension MapViewController {
    public func setupPanGesture(for view: UIView?) {
        guard let view = view else { return }
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panRecognizer)
        
    }
    
    @objc
    public func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            processPanGestureBegan(panGesture) // here we will remember old sheet size
        case .changed:
            processPanGestureChanged(panGesture)
        case .ended:
            processPanGestureEnded(panGesture)
        default:
            break
        }
    }
    
    public func processPanGestureBegan(_ panGesture: UIPanGestureRecognizer) {
        startInteractiveTransition()
    }
    
    public func startInteractiveTransition() {
        previousSizeBottomSheet = bottomSheetView.frame.height
    }
    public func processPanGestureChanged(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        scroll.isScrollEnabled = self.heightConstraint!.constant == self.view.bounds.height * 0.9
        updateInteractionControllerProgress(verticalTranslation: translation.y)
    }
    
    public func updateInteractionControllerProgress(verticalTranslation: CGFloat) {
        let progress = -verticalTranslation
        if previousSizeBottomSheet == 250 {
            self.heightConstraint!.constant = max(min(progress + 250,
                                                      self.view.bounds.height * 0.9),
                                                  250)
        }
        else {
            self.heightConstraint!.constant = min(max(self.view.bounds.height * 0.9 + progress,
                                                      250),
                                                  self.view.bounds.height * 0.9)
        }
        if previousSizeBottomSheet >= 250 && progress > 0 {
            scroll.updateImageConstraint(self.heightConstraint!.constant / (self.view.bounds.height * 0.9) - 0.35)
        }
        self.view.layoutIfNeeded()
    }
    
    public func processPanGestureEnded(_ panGesture: UIPanGestureRecognizer) {
        let velocity = panGesture.velocity(in: bottomSheetView)
        let translation = panGesture.translation(in: bottomSheetView)
        endInteractiveTransition(verticalVelocity: velocity.y, 
                                 verticalTranslation: translation.y)
    }
    
    public func endInteractiveTransition(verticalVelocity: CGFloat, verticalTranslation: CGFloat) {
        let deceleration = 800.0 * (verticalVelocity > 0 ? -1.0 : 1.0)
        let finalProgress = -(verticalTranslation - 0.5 * verticalVelocity * verticalVelocity / CGFloat(deceleration))
        / bottomSheetView.bounds.height
        
        endInteractiveTransition(finalProgress: finalProgress)
    }
    
    public func endInteractiveTransition(finalProgress: Double) {
        if finalProgress < 0 {
            scroll.isScrollEnabled = false
            UIView.animate(withDuration: 0.1) {
                self.scroll.contentOffset.y = 0
            }
            UIView.animate(withDuration: 0.15) {
                self.centerYConstraintPoints!.constant = self.pointsBottomSheetView.bounds.height - 40
                if self.heightConstraint!.constant == 250 {
                    if !RouteHolder.shared.stops.isEmpty {
                        self.centerYConstraintPoints!.constant = self.pointsBottomSheetView.bounds.height - 290
                    }
                    self.centerYConstraint!.constant = self.bottomSheetView.bounds.height - 40
                }
                self.scroll.updateImageConstraint(0.01)
                self.heightConstraint!.constant = 250
                self.view.layoutIfNeeded()
            }
        }
        else {
            scroll.isScrollEnabled = true
            scroll.bounces = true
            UIView.animate(withDuration: 0.15) {
                self.heightConstraint!.constant = self.view.bounds.height * 0.9
                self.scroll.updateImageConstraint(1)
                self.view.layoutIfNeeded()
            }
        }
    }
}
