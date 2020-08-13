//
//  GetDirectionsController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/12/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class GetDirectionsController: UIViewController {

    private let getDirectionsView = GetDirectionsView()
    private let coreLocManager = CoreLocationManager()
    private let currentVenue: Venue
    private var steps: [String] = [] {
        didSet {
            dump(steps)
        }
    }
    
    init(_ venue: Venue) {
        self.currentVenue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = getDirectionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        configureRoute()
    }

    private func setUp() {
        getDirectionsView.mapView.delegate = self
        getDirectionsView.backButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
    }
    
    private func configureRoute() {
        let currentUserLoc = getDirectionsView.mapView.userLocation
        let sourceLocation = CLLocationCoordinate2D(latitude: currentUserLoc.coordinate.latitude, longitude: currentUserLoc.coordinate.longitude)
        let destination = CLLocationCoordinate2D(latitude: currentVenue.lat, longitude: currentVenue.long)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemark = MKPlacemark(coordinate: destination)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = coreLocManager.createAnnotation(sourceLocation, "Your location")
        
        let destinationAnnotation = coreLocManager.createAnnotation(destination, currentVenue.name)
        
        if let location = sourcePlacemark.location, let destination = destinationPlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
            destinationAnnotation.coordinate = destination.coordinate
        }
        
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { [weak self] (response, error) in
            
            if let error = error {
                self?.showAlert(title: "Calculation Error", message: "Could not calculate route. Error: \(error.localizedDescription)")
                return
            }
            
            if let route = response?.routes.first{
                self?.getDirectionsView.mapView.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self?.getDirectionsView.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                self?.steps = route.steps.map{ $0.instructions }
            }
        }
    }
    
    @objc
    private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension GetDirectionsController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else { return MKOverlayRenderer() }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
}
