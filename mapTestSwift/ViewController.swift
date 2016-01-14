//
//  ViewController.swift
//  mapTestSwift
//
//  Created by Dustin M on 1/10/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit
import MapKit //added with MKMapViewDelegate class
import CoreLocation //added with CLLocationManager Delegate class, to get user location

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager() //for user location
    
    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add map with location centered, and zoom set
        
        var latitude:CLLocationDegrees = 28.375271
        var longitude:CLLocationDegrees = -81.549430
        var latDelta:CLLocationDegrees = 0.01
        var longDelta:CLLocationDegrees = 0.01
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        //add annotations to map
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "EPCOT Center"
        annotation.subtitle = "at Disney World"
        map.addAnnotation(annotation)
        
        //add annotation with long press
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        //add user location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    func action(gestureRecognizer:UIGestureRecognizer) {
        print("Gesture Recognized")
        
        //location of long press relative to map
        var touchPoint = gestureRecognizer.locationInView(self.map)
        
        //convert point to a coordinate
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "User Point"
        annotation.subtitle = "set by long press"
        map.addAnnotation(annotation)
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        var userLocation: CLLocation = locations[0]
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta:CLLocationDegrees = 0.05
        var longDelta:CLLocationDegrees = 0.05
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

