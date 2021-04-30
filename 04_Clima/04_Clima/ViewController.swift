//
//  ViewController.swift
//  04_Clima
//
//  Created by Arturo Iván Chávez Gómez on 29/04/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,UITextFieldDelegate, WeatherManagerDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var lonUser: CLLocationDegrees = 0.0
    
    var latUser: CLLocationDegrees = 0.0
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    @IBAction func gpsButton(_ sender: UIButton) {
        weatherManager.searchDevice(lon: Double(lonUser), lat: Double(latUser))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lonUser = locValue.longitude
        latUser = locValue.latitude
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        //searchTextField.text = ""
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Write something..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.searchWeather(city: searchTextField.text!)
        searchTextField.text = ""
    }
    
    func updateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
                self.temperatureLabel.text = weather.tempString
                self.cityLabel.text = weather.cityName
                self.weatherConditionImageView.image = UIImage(systemName: weather.weatherCondition)
                if(weather.temp > 20){
                    self.backgroundImageView.image = UIImage(named: "background2")
                } else {
                    self.backgroundImageView.image = UIImage(named: "background")
                }
                self.feelsLikeLabel.text = String(weather.feels_like)
                self.humidityLabel.text = String(weather.humidity)
        }
    }
    
}

