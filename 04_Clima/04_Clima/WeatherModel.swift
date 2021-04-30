//
//  WeatherModel.swift
//  04_Clima
//
//  Created by Arturo Iván Chávez Gómez on 29/04/21.
//

import Foundation

struct  WeatherModel {
    let id: Int
    let temp: Double
    let feels_like: Double
    let lon: Double
    let lat: Double
    let humidity: Int
    let cityName: String
    
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var weatherCondition: String {
        switch id {
        case 200...232:
            return "cloud.bold.fill"
        case 300...331:
            return "cloud.hail.fill"
        case 500...531:
            return "cloud.sleet.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return "sun.dust.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.sun.fill"
        default:
            return "cloud.fill"
        }
    }
}
