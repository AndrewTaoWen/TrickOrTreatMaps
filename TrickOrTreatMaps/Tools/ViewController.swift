//
//  ViewController.swift
//  TrickOrTreatMaps
//
//  Created by Andrew Wen on 2024-11-05.
//

import UIKit
import CoreLocation

public class ViewController: UIViewController {

    var locationManager: CLLocationManager?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
        case .authorizedWhenInUse:
            print("When user select option Allow While Using App or Allow Once")
        default:
            print("default")
        }
    }
}
