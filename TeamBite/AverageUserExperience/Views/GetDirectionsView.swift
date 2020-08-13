//
//  GetDirectionsView.swift
//  TeamBite
//
//  Created by Cameron Rivera on 8/12/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit
import MapKit

class GetDirectionsView: UIView {
    
    public lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }()
    
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = UIColor.black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpMapViewConstraints()
        setUpBackButtonConstraints()
    }
    
    private func setUpMapViewConstraints() {
        addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), mapView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), mapView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    
    private func setUpBackButtonConstraints() {
        mapView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8), backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8), backButton.heightAnchor.constraint(equalToConstant: 50), backButton.widthAnchor.constraint(equalToConstant: 50)])
    }

}
