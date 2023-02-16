//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/31.
//

import Foundation

extension DateFormatter {

    static var MdEEE: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d (EEE)"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
    
    static var Md: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
    
    static var H: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }
}
