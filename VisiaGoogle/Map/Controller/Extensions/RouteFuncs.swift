//
//  RouteFuncs.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 02.12.2023.
//

import Foundation
import UIKit

extension MapViewController {
    @objc func addStop() {
        RouteHolder.shared.addNewStop(selectedMarker!)
        pointsScrollView.updateData()
        UIView.animate(withDuration: 0.35) {
            self.centerYConstraint!.constant = self.bottomSheetView.bounds.height - 40
            self.view.layoutIfNeeded()
            self.scroll.updateImageConstraint(0.01)
        }
        UIView.animate(withDuration: 0.35) {
            self.centerYConstraintPoints!.constant = 0
            self.heightConstraintPoints!.constant = 290 + CGFloat(min(RouteHolder.shared.stops.count,
                                                                      7) * 55)
            self.pointsScrollView.updateTableHeight(constant: CGFloat(min(RouteHolder.shared.stops.count,
                                                                     7) * 55))
            self.view.layoutIfNeeded()
        }
        self.scroll.isScrollEnabled = false
        self.view.layoutIfNeeded()
    }
    
    @objc func drawRoute() {
        RouteHolder.shared.drawRoute()
    }
    
    @objc func removeRoutes() {
        RouteHolder.shared.removeRoutes()
        // вынести в отдельный метод
        UIView.animate(withDuration: 0.35) {
            self.heightConstraintPoints!.constant = 290 + CGFloat(min(RouteHolder.shared.stops.count,
                                                                      7) * 55)
            self.centerYConstraintPoints!.constant = self.pointsBottomSheetView.bounds.height - 40
            NSLayoutConstraint.activate([self.tableHeightAnchor!])
            self.view.layoutIfNeeded()
        }
    }
}
