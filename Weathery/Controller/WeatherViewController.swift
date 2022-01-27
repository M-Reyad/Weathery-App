//
//  WeatherDataManager.swift
//  Weathery
//
//  Created by Mohamed Reyad on 10/5/21.
//

import UIKit
import CoreLocation

class WeatherViewController : UIViewController  {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var weatherdata = WeatherDataManager()
    let coreLocator = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.delegate = self
        weatherdata.delegate = self
        coreLocator.delegate = self
        
    }

    
    @IBAction func locationPressed(_ sender: UIButton) {
        coreLocator.requestWhenInUseAuthorization()
        coreLocator.requestLocation()
        

    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchField.endEditing(true)
        print(searchField.text!)
        weatherdata.fetchWeatherData(city: searchField.text!)


    }
}
//MARK: - Text Field Extensions
     
        
    extension WeatherViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        print(searchField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text{
            weatherdata.fetchWeatherData(city: city)
        }
        searchField.text = ""
            }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != "" {
            return true
        }
        else {
            searchField.placeholder = "Type Something Here!"
            return false
        }
    }
    }
    //MARK: - Update Weather Delegate
    
    extension WeatherViewController : UpdateWeatherDelegate {
    func didUpdateWeather(_ weather: Results){
        cityLabel.text = weather.name
        temperatureLabel.text = String(format: "%0.2f", weather.temp)
        conditionImageView.image = UIImage(systemName: weather.id)
        print(weather)
}

}

//MARK: - Get Location
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let location = locations.last {
            let long = location.coordinate.longitude
            let lat = location.coordinate.latitude
            weatherdata.fetchWeatherData(longitude: long , latitude: lat)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
