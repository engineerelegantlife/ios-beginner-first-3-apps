//
//  Util.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/31.
//

import Foundation

class Util {
    
    static func getImageNameByWeatherId(id: Int) -> String {
        switch id {
        case 200 ..< 300:
            return "thunderstorms"
        case 300 ..< 400:
            return "fog"
        case 500 ..< 600:
            return "rain"
        case 600 ..< 700:
            return "snow"
        case 700 ..< 800:
            return "mist"
        case 800:
            return "sunny"
        case 801 ... 804:
            return "cloud"
        default:
            return "sunny"
        }
    }
}
