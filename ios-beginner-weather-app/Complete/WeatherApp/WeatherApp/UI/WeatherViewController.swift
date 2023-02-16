//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/16.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    var latitude: Double = 35.681236
    var longitude: Double = 139.767125
    
    var weatherList: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradient()
        setGradientForText()
        
        contentStackView.isHidden = true
        
        // 位置情報許諾
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func setGradient() {
        let color1 = UIColor(hex: "5A8DEE")
        let color2 = UIColor(hex: "6EC0F5")
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            color1.withAlphaComponent(1.0).cgColor,
            color2.withAlphaComponent(1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: -1.0)
        gradientLayer.frame = self.view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientForText() {
        // do something
    }
    
    func fetchWeatherData() {
        AF.request("\(API.baseUrl)?units=metric&lang=ja&lat=35.681236&lon=139.767125&appid=\(API.key)",
                   method: .get,
                   encoding: JSONEncoding.default).response { response in
            
            guard let data = response.data else { return }
            
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                
                result.list.forEach {
                    self.weatherList.append($0)
                }
                
                self.updateLayout(result)
            }
            catch {
                // do something
            }
        }
    }
    
    func updateLayout(_ result: Result) {
        locationLabel.text = result.city.name
        temperatureLabel.text = "\(Int(weatherList[0].main.temp))°"
        weatherLabel.text = weatherList[0].weather[0].description
        weatherImageView.image = UIImage(named: Util.getImageNameByWeatherId(id: weatherList[0].weather[0].id))
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(weatherList[0].dt))
        dateLabel.text = "今日\((date as Date).MdEEE)"
        
        contentStackView.isHidden = false
        showModalView()
    }
    
    func showModalView() {
        let vc = storyboard?.instantiateViewController(identifier: "WeatherDetail") as! WeatherDetailViewController
        vc.weatherList = self.weatherList
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { context in 0.7*context.maximumDetentValue },
                .custom { context in 0.3*context.maximumDetentValue },
            ]
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlertView() {
        let alert: UIAlertController = UIAlertController(title: "位置情報の利用が許可されていません",
                                                         message:  "設定アプリを開きますか？",
                                                         preferredStyle: .alert)
        
        let yesAction: UIAlertAction = UIAlertAction(title: "はい",
                                                     style: UIAlertAction.Style.default,
                                                     handler: { _ in
            // 設定アプリを開く
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル",
                                                        style: .cancel,
                                                        handler: { _ in
        })
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
            showAlertView()
        case .authorizedAlways:
            print("Authorized Always")
        case .authorizedWhenInUse:
            print("Authorized When in Use")
        @unknown default:
            print("Unknown status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        self.latitude = location?.coordinate.latitude ?? 0
        self.longitude = location?.coordinate.longitude ?? 0
        
        self.fetchWeatherData()
        
        self.locationManager.stopUpdatingLocation()
    }
}
