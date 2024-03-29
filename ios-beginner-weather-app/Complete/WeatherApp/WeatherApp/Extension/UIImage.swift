//
//  UIImage.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/21.
//

import UIKit

extension UIImage {
    
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        
        self.init()
    }
}
