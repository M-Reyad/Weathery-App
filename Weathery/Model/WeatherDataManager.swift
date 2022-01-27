//
//  WeatherDataManager.swift
//  Weathery
//
//  Created by Mohamed Reyad on 10/5/21.
//
//MARK:- Protocols
protocol UpdateWeatherDelegate {
    func didUpdateWeather(_ weather: Results)
}

//MARK:- Weather Data Model
import UIKit
import CoreLocation


struct WeatherDataManager {
    
    var delegate : UpdateWeatherDelegate?
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=dc06ad3885a1c070b182868c2623ccd2&units=metric"

    mutating func fetchWeatherData (city : String){
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=dc06ad3885a1c070b182868c2623ccd2&q=\(city)&units=metric"
        print(weatherURL)
        createURL(url: weatherURL)
    }
    mutating func fetchWeatherData (longitude : CLLocationDegrees, latitude : CLLocationDegrees ){
        weatherURL = "https://api.openweathermap.org/data/2.5/weather?APPID=dc06ad3885a1c070b182868c2623ccd2&lat=\(latitude)&lon=\(longitude)&units=metric"
        print(weatherURL)
        createURL(url: weatherURL)
    }
    
    // 1- Create URL
   func createURL(url : String){
        if let url = URL(string: url){
            let sessionURL = url
    // 2- Create URL Session
            let session = URLSession(configuration: .default)
        
    // 3- Give URL Session a task
            let task = session.dataTask(with: sessionURL) {(data,response,error) in
            if error != nil{
                print(error!)
                return
            }
            if let safeData = data{

                self.decodingData(data: safeData)
                
                }
            }
    // 4- Start the task!
            task.resume()
        }
    }
    
    func decodingData(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(APIData.self, from: data)
            DispatchQueue.main.async { let results = Results(name: decodedData.name, temp: decodedData.main.temp, idNum: decodedData.weather[0].id )
            
            self.delegate?.didUpdateWeather(results)
                print("EnteredDecodingData")}
        } catch  {
            print(error)
            
        }
        
    }
        

}
