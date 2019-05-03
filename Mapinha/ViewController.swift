//
//  ViewController.swift
//  Mapinha
//
//  Created by student on 11/05/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        addGesture()
        
        mapView.showsUserLocation = true
        
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }

    
    func setupLocationManager(){
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0{
            
            if let location = locations.last{
                
               userLocation = location
                print("A localizacao atual do usuario e:", userLocation.coordinate)
            }
        }
        
//        let location = locations[0]
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//        mapView.setRegion(region, animated: true)
//        
    
    }
    
    func addGesture(){
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap(gestureRecognizer:)))
        
        longPress.minimumPressDuration = 1.0
        
        mapView.addGestureRecognizer(longPress)
    }
    
    func addAnnotationToMap(gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Hackatruck"
        newAnnotation.subtitle = String(describing: "Latitude:\(newCoordinate.latitude) / Longitude:\(newCoordinate.longitude)")
        
        mapView.addAnnotation(newAnnotation)
        
        
    }
}

