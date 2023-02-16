//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?units=metric&lang=ja&lat=35.681236&lon=139.767125&appid=b78a883a1a85d6e2a76737f97cdeb495",
                   method: .get,
                   encoding: JSONEncoding.default).response { response in
            
            switch response.result {
            case .success:
                let json = JSON(response.data as Any)
                
                /*
                 TODO: -
                 ・日付
                 ・天気の画像
                 */
                
                self.locationLabel.text = "\(json["city"]["name"])"
                self.temperatureLabel.text = "\(Int(truncating: json["list"][0]["main"]["temp"].number!))°"
                self.weatherLabel.text = "\(json["list"][0]["weather"][0]["description"])"
                                
            case .failure(let error):
                print(error)
            }
        }
    }
}

