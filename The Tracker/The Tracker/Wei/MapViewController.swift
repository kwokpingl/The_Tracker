//
//  MapViewController.swift
//  The Tracker
//
//  Created by Jimmy on 2018/2/12.
//  Copyright © 2018年 WSJ. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map:MKMapView!
    @IBOutlet weak var mapSegmentedControl: UISegmentedControl!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        map.delegate = self
        map.showsUserLocation = true
        map.userTrackingMode = .follow
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        
    }
    
    
    
    
}
