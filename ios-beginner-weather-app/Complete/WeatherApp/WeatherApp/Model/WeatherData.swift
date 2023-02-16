//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/21.
//

import Foundation

struct Result: Codable {
    var list: [List]
    var city: City
}

struct City: Codable {
    var name: String
}

struct List: Codable {
    var dt: Int
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
}
