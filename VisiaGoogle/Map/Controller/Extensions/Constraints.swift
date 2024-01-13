//
//  Constraints.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 02.12.2023.
//

import Foundation
import UIKit
import GoogleMaps

// MARK: constraints and related
extension MapViewController {
    func addMap(_ map: GMSMapView) {
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: view.topAnchor),
            map.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        // MARK: settting delegate
        map.delegate = self
        self.map = map // to use delegate methods
    }
    
    func setConstraints() {
        [pointsBottomSheetView,
         bottomSheetView].forEach { views in
            views.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(views)
        }
        
        NSLayoutConstraint.activate([
            bottomSheetView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            bottomSheetView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            pointsBottomSheetView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            pointsBottomSheetView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        centerYConstraint = bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                    constant: 360)
        
        centerYConstraintPoints = pointsBottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                    constant: 460)
        
        heightConstraint = bottomSheetView.heightAnchor.constraint(equalToConstant: 250)
        
        heightConstraintPoints = pointsBottomSheetView.heightAnchor.constraint(equalToConstant: 290 + CGFloat(min(RouteHolder.shared.stops.count,
                                                                                                                  7) * 55))
        
        NSLayoutConstraint.activate([self.centerYConstraint!,
                                     self.heightConstraint!,
                                     
                                     self.centerYConstraintPoints!,
                                     self.heightConstraintPoints!])
        
        setupPanGesture(for: bottomSheetView)
        setupPanGesturePoints(for: pointsBottomSheetView)
        
        [scroll,
         bottomSheetViewAddButton,
         interactionImageView].forEach { views in
            bottomSheetView.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            
                interactionImageView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor),
                interactionImageView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor,
                                                          constant: 5),
                interactionImageView.widthAnchor.constraint(equalToConstant: 52),
                interactionImageView.heightAnchor.constraint(equalToConstant: 6),
            
            
            bottomSheetViewAddButton.widthAnchor.constraint(equalToConstant: 341),
            bottomSheetViewAddButton.heightAnchor.constraint(equalToConstant: 36),
            bottomSheetViewAddButton.leftAnchor.constraint(equalTo: bottomSheetView.leftAnchor,
                                                           constant: 24),
            bottomSheetViewAddButton.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor,
                                                             constant: -90),
                
                scroll.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
                
                scroll.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor,
                                               constant: -5),
                
                scroll.widthAnchor.constraint(equalTo: bottomSheetView.widthAnchor)
        ])
        
        
        [pointsScrollView,
         createRouteButton].forEach { views in
            pointsBottomSheetView.addSubview(views)
            views.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            pointsScrollView.topAnchor.constraint(equalTo: pointsBottomSheetView.topAnchor),
            
            pointsScrollView.bottomAnchor.constraint(equalTo: pointsBottomSheetView.bottomAnchor,
                                           constant: -5),
            pointsScrollView.widthAnchor.constraint(equalTo: pointsBottomSheetView.widthAnchor),
        
            createRouteButton.widthAnchor.constraint(equalToConstant: 341),
            createRouteButton.heightAnchor.constraint(equalToConstant: 42),
            createRouteButton.leftAnchor.constraint(equalTo: pointsBottomSheetView.leftAnchor,
                                                           constant: 24),
            createRouteButton.bottomAnchor.constraint(equalTo: pointsBottomSheetView.bottomAnchor,
                                                             constant: -90),
        ])
    }
}
