//
//  Date.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/31.
//

import Foundation

extension Date {
    
    var MdEEE: String {
        return DateFormatter.MdEEE.string(from: self)
    }
    
    var Md: String {
        return DateFormatter.Md.string(from: self)
    }
    
    var H: String {
        return DateFormatter.H.string(from: self)
    }
}
