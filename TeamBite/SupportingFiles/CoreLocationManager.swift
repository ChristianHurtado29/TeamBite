//
//  CoreLocationManager.swift
//  TeamBite
//
//  Created by Christian Hurtado on 4/20/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol CoreLocationManagerDelegate: AnyObject {
    func locationChanged(_ coreLocationManager: CoreLocationManager, _ locations: [CLLocation])
}

class CoreLocationManager: NSObject{
    
    public var locationManager: CLLocationManager
    weak var delegate: CoreLocationManagerDelegate?
    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func convertCoordinateIntoPlacemark(_ coordinate: CLLocationCoordinate2D, completion: @escaping (Result<CLPlacemark,Error>) -> ()){
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let firstPlacemark = placemarks?.first {
                completion(.success(firstPlacemark))
            }
            
        }
    }
    
    public func convertPlacenameIntoCoordinates(_ placename: String, completion: @escaping (Result<CLLocationCoordinate2D,Error>) -> ()){
        
        CLGeocoder().geocodeAddressString(placename) { (placemarks, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let firstPlacemark = placemarks?.first, let location = firstPlacemark.location {
                completion(.success(location.coordinate))
            }
        }
    }
    
    public func monitorSignificantChanges(){
        if !CLLocationManager.significantLocationChangeMonitoringAvailable(){
            return
        }
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    public func createAnnotation(_ coordinates: CLLocationCoordinate2D, _ locationName: String) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = locationName
        return annotation
    }
}

extension CoreLocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locationManager.location {
            delegate?.locationChanged(self, locations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
    }
}
