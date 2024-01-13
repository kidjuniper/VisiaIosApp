//
//  MarkerProviderProtocol.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 17.11.2023.
//

import Foundation

protocol MarkersProviderProtocol {
    func markersArray(_ complition: ([Marker]) -> Void)
    func setMarkers()
    func setMarkersClose()
    func resetMarkers()
}
