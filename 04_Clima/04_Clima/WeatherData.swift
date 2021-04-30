//
//  WeatherData.swift
//  04_Clima
//
//  Created by Arturo Iván Chávez Gómez on 29/04/21.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let id: Int
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}
