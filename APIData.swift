//
//  WeatherDataManager.swift
//  Weathery
//
//  Created by Mohamed Reyad on 10/5/21.
//

import Foundation
struct APIData : Decodable{
    var name : String
    var main : Main
    var weather : [Weather]
    
}
struct Main : Decodable {
    var temp : Double
}
struct Weather : Decodable{
    var id : Int
}
