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
    var selectedOffers: [Offer] = [] {
        didSet {
            detailView.offersTableView.reloadData()
            if selectedOffers.count == 0 {
                detailView.offersTableView.separatorStyle = .none
                detailView.offersTableView.backgroundView = EmptyView(title: "No Offers", message: "This venue currently has no offerings.")
            } else {
                detailView.offersTableView.separatorColor = UIColor.black
                detailView.offersTableView.separatorStyle = .singleLine
                detailView.offersTableView.backgroundView = nil
            }
        }
    }
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
        configureMapView()
        updateUI()
        loadMap()
        loadVenue()
        getDirections()
        getOffers()
        configureGetDirectionsButton()
        configureOffersTableView()
    }
    
    private func configureMapView() {
        detailView.locationMap.delegate = self
        detailView.locationMap.showsUserLocation = true
        detailView.locationMap.showsPointsOfInterest = true
        detailView.locationMap.showsScale = true
        locationManger.requestAlwaysAuthorization()
        locationManger.requestWhenInUseAuthorization()
    }
    
    private func updateUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.title = selectedVenue?.name
        
        if let start = selectedVenue?.startTime, let end = selectedVenue?.endTime {
        detailView.hoursOFOperation.text = """
Start Time: \(start)
            
End Time: \(end)
"""
        }
        
        detailView.thisNeedsTobeRefactor.text = """
        Address:
        \(selectedVenue?.address ?? "No Address")
        """
        detailView.refactor.text = "Phone: \(selectedVenue?.phoneNumber ?? "No Phone")"
        
        // Have to add resturant picture !!
        
    }
    
    private func loadMap() {
        guard let ven = selectedVenue else { return }
        let annotation = makeAnnotation(for: ven)
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
    
    private func configureGetDirectionsButton() {
        detailView.getDirectionButton.addTarget(self, action: #selector(getDirectionButtonPressed), for: .touchUpInside)
    }
    
    private func configureOffersTableView() {
        detailView.offersTableView.delegate = self
        detailView.offersTableView.dataSource = self
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
        let coordinate = CLLocationCoordinate2D(latitude: selectedVenue?.lat ?? 0.0, longitude: selectedVenue?.long ?? 0.0)
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
    
    func openMapForPlace(){
        let lat1: NSString = (self.selectedVenue?.lat.description ?? "0.0") as NSString
        let long1: NSString = (self.selectedVenue?.long.description ?? "0.0") as NSString
        
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
        mapItem.name = "\(self.selectedVenue?.name ?? "")"
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func getOffers() {
        guard let venue = selectedVenue else { return }
        DatabaseService.shared.fetchVenueOffers(venue.venueId) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            case .success(let offers):
                self?.selectedOffers = offers
            }
        }
    }
    
    //MARK: Claim Button
    @objc private func claimButton(_ sender: UIButton) {

    }
    
    //MARK: Get Direction Button
    @objc private func GetDirection(_ sender: UIButton) {
        openMapForPlace()
    }
    
    @objc private func getDirectionButtonPressed(_ sender: UIButton) {
        getDirections()
    }

}

//MARK: Extension for Mapkit
extension UserDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.tintColor = .black
            annotationView?.markerTintColor = .systemRed
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
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

extension UserDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOffers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let xCell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as? PatronOfferCell else {
            fatalError("Could not dequeue UITableViewCell as an OffersCell. ")
        }
        
        xCell.configureCell(selectedOffers[indexPath.row])
        return xCell
    }
    
}

extension UserDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offerVC = PatronOfferDetailController( selectedOffers[indexPath.row])
        navigationController?.pushViewController(offerVC, animated: true)
    }
    
}

