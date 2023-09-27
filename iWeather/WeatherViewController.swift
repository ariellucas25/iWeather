//
//  ViewController.swift
//  iWeather
//
//  Created by Ariel Lucas  Luduvig on 19/09/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    var isDay: Int?
    @IBOutlet weak var yourLocationButton: UIButton!
    
    let gradientLayer = CAGradientLayer()
    
    var lat = 11.344555
    var lon = 104.33322
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        setUpLocationManager()
        
        backgroundView.layer.addSublayer(gradientLayer)
      
        getWeather(cityName: "\(lat),\(lon)", apiKey: "b619822c294546dcb33220134231909 ") { weather in
            if let weather = weather {
            self.isDay = weather.isDayNum
            self.cityLabel.text = weather.city
            self.descriptionLabel.text = weather.description
            self.weatherIcon.image = weather.weatherIcon
            self.temperature.text = weather.temperature
        }
            if self.isDay == 1 {
                self.setBlueGradientBackground()
            } else {
                self.setGreyGradientBackground()
            }
        }
    }
    
    private func setUpLocationManager(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        if let cityName = cityTextField.text, !cityName.isEmpty {
            getWeather(cityName: cityName, apiKey: "b619822c294546dcb33220134231909") { weather in
                if let weather = weather {
                    self.isDay = weather.isDayNum
                    self.cityLabel.text = weather.city
                    self.descriptionLabel.text = weather.description
                    self.weatherIcon.image = weather.weatherIcon
                    self.temperature.text = weather.temperature
                    
                    if self.isDay == 1 {
                        self.setBlueGradientBackground()
                    } else {
                        self.setGreyGradientBackground()
                    }
                }
            }
        }
    }
    
    
    @IBAction func yourLocationButtonTapped(_ sender: UIButton) {
            getWeather(cityName: "\(lat), \(lon)", apiKey: "b619822c294546dcb33220134231909") { weather in
                if let weather = weather {
                    self.isDay = weather.isDayNum
                    self.cityLabel.text = weather.city
                    self.descriptionLabel.text = weather.description
                    self.weatherIcon.image = weather.weatherIcon
                    self.temperature.text = weather.temperature
                    
                    if self.isDay == 1 {
                        self.setBlueGradientBackground()
                    } else {
                        self.setGreyGradientBackground()
                    }
                }
            }
        }
    
    func setBlueGradientBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }

    func setGreyGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}

extension ViewController: UITextFieldDelegate {
    // Remove this method if it's already implemented elsewhere
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
    }
}


