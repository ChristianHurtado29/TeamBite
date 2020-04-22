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
    
    var selectedVenue: Venue!
    var selectedOffer: Offer!
    let detailView = UserDetailView()
    private var annotation = MKPointAnnotation()
    private var isShowingNewAnnotation = false
    
    
    private var detailVenues = [Venue]()
    
    override func loadView() {
        view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        updateUI()
        loadMap()
        getDirections()
        loadVenue()
        
     
    }
    private func updateUI() {
        detailView.restaurantInfo.text = ("\(selectedVenue.name.capitalized), Phone Number: \(selectedVenue.phoneNumber), Address: \(selectedVenue.address)")
        detailView.hoursOFOperation.text = ("Start Time: \(selectedVenue.startTime), End Time: \(selectedVenue.endTime)")
        detailView.numberOfMeals.text = ("Total of Meals: \(selectedOffer.totalMeals.description), Meals Remaining \(selectedOffer.remainingMeals)")
        
        // Have to add resturant picture !!
        
    }
    
    private func loadMap() {
        let annotation = makeAnnotation(for: selectedVenue)
        detailView.locationMap.addAnnotation(annotation)
        getDirections()
    }
    
    private func loadVenue(){
        
    }
    
    private func makeAnnotation(for venue: Venue) -> MKPointAnnotation {
        selectedVenue = venue
        let annotation = MKPointAnnotation()
        
        let coordinate = CLLocationCoordinate2D(latitude: venue.lat, longitude: venue.long)
        annotation.title = venue.name
        annotation.coordinate = coordinate
        
        isShowingNewAnnotation = true
        self.annotation = annotation
        return annotation
    }
    
    private func getDirections() {
        let coordinate = CLLocationCoordinate2D(latitude: selectedVenue.lat, longitude: selectedVenue.long)
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        request.transportType = .any
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let unwrappedResponse = response else { request }
            for route in unwrappedResponse.routes {
                self.detailView.locationMap.addOverlay(route.polyline)
                self.detailView.locationMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    


}

//MARK: Extension for Mapkit
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
        if isShowingNewAnnotation {
            detailView.locationMap.showAnnotations([annotation], animated: false)
        }
        isShowingNewAnnotation = false
    }
    
}
