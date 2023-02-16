//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weatherList: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: 66, height: 113)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "WeatherDetailCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "WeatherDetailCollectionViewCell")
    }
}

extension WeatherDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailCollectionViewCell",
                                                      for: indexPath)

        if let cell = cell as? WeatherDetailCollectionViewCell {
            cell.setupCell(dt: weatherList[indexPath.row].dt, weather: weatherList[indexPath.row].weather[0])
        }
        
        return cell
    }
}

extension WeatherDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // セルがタップされた時の挙動を記述
    }
}
