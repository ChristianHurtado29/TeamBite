//
//  UserDetailViewController.swift
//  TeamBite
//
//  Created by Margiett Gil on 4/22/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class UserDetailViewController: UIViewController {
    
    var selectedVenue: Venue?
    let detailView = UserDetailView()
    private var annotation = MKPointAnnotation()
    private var isShowingNewAnnotation = false
    
    
    private var detailVenues = [Venue]() {
        didSet {
        
        }
    }
    
    override func loadView() {
        view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    private func loadMap() {
        let annotation = makeAnnotation(for: selectedVenue)
        detailView.locationMap.addAnnotation(annotation)
    }
    
    private func makeAnnotation(for venue: Venue) -> MKPointAnnotation {
        selectedVenue = venue
        let annotation = MKPointAnnotation()
        
        let coordinate = CLLocationCoordinate2D(latitude: venue.latitude, longitude: venue.longitude)
        annotation.title = venue.name
        annotation.coordinate = coordinate
        
        isShowingNewAnnotation = true
        self.annotation = annotation
        return annotation
    }
    


}

extension UserDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView == MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .black
            annotationView?.markerTintColor = .systemRed
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKPolygonRenderer {
        let renderer = MKPolygonRenderer(polygon: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWideth = 3.0
        
        return renderer
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewAnnotations {
            detailView.locationMap.showAnnotations([annotation], animated: false)
        }
        isShowingNewAnnotation = false
    }
    
}
