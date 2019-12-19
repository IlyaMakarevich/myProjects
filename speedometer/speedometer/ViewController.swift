//
//  ViewController.swift
//  speedometer
//
//  Created by MacBook Pro  on 18.12.2019.
//  Copyright © 2019 MacBook Pro . All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var speed: CLLocationSpeed = CLLocationSpeed()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Get Ready!"
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        speedLabel.alpha = 0.0
        speedLabel.fadeIn(1)
        
    }
    
    private func setupView() {
        view.addSubview(speedLabel)
        NSLayoutConstraint.activate([
            speedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // "locations" contain the arrays of Data, in order to get the latest data we have to use the last one so,
        // the last Data will be locations[locations.count - 1]
        let location = locations[locations.count - 1]
        
        // To know if the Data that our device is correct, The "horizontalAccuracy" value should be grater then ZERO for valid GPS coordinate Data
        if location.horizontalAccuracy > 0 {
            
            //TODO: Step 7 ####################################################################
            // Time to stop collecting GPS data, as it will keep updating and will kill the battry of Device if we don't
            //locationManager.stopUpdatingLocation()
            
            
            // Getting coordinate
            let Longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            
            // Getting Speed
            // The instantaneous speed of the device, measured in meters per second.
            let speed = location.speed
            print(speed)
            if (speed > 0) {
                speedLabel.text = (String(format: "%.0f km/h", speed)) } else {
                speedLabel.text = "0 km/h"
            }
            // Getting no. of floor
            // The logical floor of the building in which the user is located.
            let floor = location.floor
            
            // Getting The when the GPS data was taken
            let timeStamp = location.timestamp
            
            // The direction in which the device is traveling.
            let courseDirection = location.course
            
            // The altitude, measured in meters.
            // Positive values indicate altitudes above sea level. Negative values indicate altitudes below sea level.
            let hightFromSeaLevel = location.altitude
        }
    }
    
    // when there is an Error while collecting GPS coordinate data by "locationManager" this method is called
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
}

extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.3) {
        fadeTo(1.0, duration: duration)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.3) {
        fadeTo(0.0, duration: duration)
    }
}

