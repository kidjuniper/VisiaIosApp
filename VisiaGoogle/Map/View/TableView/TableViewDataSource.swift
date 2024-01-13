//
//  TableViewDataSource.swift
//  VisiaGoogle
//
//  Created by Nikita Stepanov on 02.12.2023.
//

import Foundation
import UIKit

extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RouteHolder.shared.stops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.directionsTableView.dequeueReusableCell(withIdentifier: "DirectionsTableViewCell", for: indexPath) as! DirectionsTableViewCell
        cell.placeLabel.text = RouteHolder.shared.stops[indexPath.row].title
        return cell
    }
}
