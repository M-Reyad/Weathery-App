//
//  WeatherDataManager.swift
//  Weathery
//
//  Created by Mohamed Reyad on 10/5/21.
//

import Foundation
struct Results {
    var name : String
    var temp : Double
    var idNum : Int
    var id : String {
        switch self.idNum {
        case 200...232 :
            return "cloud.bolt.rain"
        case 300...321 :
            return "cloud.drizzle"
        case 500...531 :
            return "cloud.rain"
        case 600...622 :
            return "cloud.snow"
        case 701...781 :
            return "sun.min"
        case 800 :
            return "sun.max"
        case 801...804 :
            return "cloud"
        default:
            return "sun.max"
        }
        

    }
    
}
