//
//  MapVC.swift
//  RestApiApp
//
//  Created by Евгений Забродский on 25.12.22.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocation()
    }
    
    func currentLocation() {
        infoLbl.text = user?.address?.city
        let lat = Double((user?.address?.geo?.lat)!)
        let lng = Double((user?.address?.geo?.lng)!)
        // Сделал правильные координаты только для первого юзера
        let currentLocation = CLLocation(latitude: lat!, longitude: lng!)
        mapView.centerLocation(currentLocation)
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
