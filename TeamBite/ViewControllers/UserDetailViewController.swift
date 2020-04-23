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
    var locationManger = CLLocationManager()
    
    private var annotation = MKPointAnnotation()
    private var isShowingNewAnnotation = false
    
    private var db = DatabaseService()
    private var detailVenues = [Venue]()
    
    override func loadView() {
        view = detailView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        navigationItem.title = selectedVenue.name
        detailView.locationMap.delegate = self
        detailView.locationMap.showsUserLocation = true
        detailView.locationMap.showsPointsOfInterest = true
        detailView.locationMap.showsScale = true
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
        updateUI()
        loadMap()
        getDirections()
        loadVenue()
        
     
    }
    private func updateUI() {
        detailView.restaurantInfo.text = (" ")
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
        db.fetchVenues() { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Loading Error", message: error.localizedDescription)
                }
            case .success(let item):
                self?.detailVenues = item
            }
            
        }
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
            guard let unwrappedResponse = response else { return }
            for route in unwrappedResponse.routes {
                self.detailView.locationMap.addOverlay(route.polyline)
                self.detailView.locationMap.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    //MARK: Claim Button
    @objc private func claimButton(_ sender: UIButton) {
        let claimVC = ClaimButton
        navigationController?.pushViewController(claimVC, animated: true)
        
    }
    
    
    //MARK: Get Direction Button
    @objc private func GetDirection(_ sender: UIButton) {
        openMapForPlace()
    }
    
    func openMapForPlace(){
        let lat1: NSString = self.selectedVenue.lat.description as NSString
        let long1: NSString = self.selectedVenue.long.description as NSString
        
        let latitude: CLLocationDegrees = lat1.doubleValue
        let longitude: CLLocationDegrees = long1.doubleValue
        
        let regionDistance: CLLocationDistance = 3000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(self.selectedVenue.name)"
        mapItem.openInMaps(launchOptions: options)
        
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
        let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
        renderer.strokeColor = UIColor.systemBlue
        renderer.lineWidth = 3.0

        return renderer
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingNewAnnotation {
            detailView.locationMap.showAnnotations([annotation], animated: false)
        }
        isShowingNewAnnotation = false
    }
    
}
