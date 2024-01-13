//
//  SelectedPointsBottomSheet.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 02.12.2023.
//

import Foundation
import UIKit

extension MapViewController {
    
    public func setupPanGesturePoints(for view: UIView?) {
        guard let view = view else { return }
        let panRecognizer = UIPanGestureRecognizer(target: self, 
                                                   action: #selector(handlePanGesturePoints(_:)))
        view.addGestureRecognizer(panRecognizer)
        
    }
    
    @objc
    public func handlePanGesturePoints(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            processPanGestureBeganPoints(panGesture) // here we will remember old sheet size
        case .changed:
            processPanGestureChangedPoints(panGesture)
        case .ended:
            processPanGestureEndedPoints(panGesture)
        default:
            break
        }
    }
    public func processPanGestureBeganPoints(_ panGesture: UIPanGestureRecognizer) {
        startInteractiveTransitionPoints()
    }
    
    public func startInteractiveTransitionPoints() {
        previousSizePointsBottomSheet = pointsBottomSheetView.frame.height
    }
    
    public func processPanGestureChangedPoints(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: nil)
        let tableHeight = CGFloat(min(RouteHolder.shared.stops.count,
                                      7) * 55)
//        pointsScrollView.isScrollEnabled = self.heightConstraintPoints!.constant == 350 + tableHeight
        updateInteractionControllerProgressPoints(verticalTranslation: translation.y)
    }
    
    public func updateInteractionControllerProgressPoints(verticalTranslation: CGFloat) {
        let progress = -verticalTranslation
        let tableHeight = CGFloat(min(RouteHolder.shared.stops.count,
                                      7) * 55)
        if previousSizePointsBottomSheet == 290.0 + tableHeight {
            self.heightConstraintPoints!.constant = max(min(290 + tableHeight + progress,
                                                            350 + tableHeight),
                                                        290 + tableHeight)
        }
        else {
            self.heightConstraintPoints!.constant = min(max(350 + tableHeight + progress,
                                                            290 + tableHeight),
                                                        350 + tableHeight)
        }
        self.centerYConstraintPoints!.constant = 0
        self.view.layoutIfNeeded()
    }
    public func processPanGestureEndedPoints(_ panGesture: UIPanGestureRecognizer) {
        let velocity = panGesture.velocity(in: pointsBottomSheetView)
        let translation = panGesture.translation(in: pointsBottomSheetView)
        endInteractiveTransitionPoints(verticalVelocity: velocity.y,
                                  verticalTranslation: translation.y)
    }
    
    public func endInteractiveTransitionPoints(verticalVelocity: CGFloat,
                                                verticalTranslation: CGFloat) {
        let deceleration = 800.0 * (verticalVelocity > 0 ? -1.0 : 1.0)
        let finalProgress = -(verticalTranslation - 0.5 * verticalVelocity * verticalVelocity / CGFloat(deceleration))
        / pointsBottomSheetView.bounds.height
        
        endInteractiveTransitionPoints(finalProgress: finalProgress)
    }
    
    public func endInteractiveTransitionPoints(finalProgress: Double) {
        let tableHeight = CGFloat(min(RouteHolder.shared.stops.count,
                                      7) * 55)
        if finalProgress < 0 {
            if finalProgress < -3 || 
                self.heightConstraintPoints!.constant == 290 + tableHeight {
                self.centerYConstraintPoints!.constant = self.pointsBottomSheetView.bounds.height - 290
                self.tableHeightAnchor?.constant = 0
                UIView.animate(withDuration: 0.15) {
                    self.view.layoutIfNeeded()
                }
            }
            else {
                self.heightConstraintPoints!.constant = 290 + tableHeight
//                NSLayoutConstraint.activate([self.tableHeightAnchor!])
                UIView.animate(withDuration: 0.05) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        else if finalProgress > 0 {
            UIView.animate(withDuration: 0.05) {
                self.tableHeightAnchor?.constant = tableHeight
//                NSLayoutConstraint.activate([self.tableHeightAnchor!])
                self.heightConstraintPoints!.constant = 350 + tableHeight
                self.view.layoutIfNeeded()
            }
        }
    }
}
