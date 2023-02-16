//
//  WeatherDetailCollectionViewCell.swift
//  WeatherApp
//
//  Created by Tomo Shimizu on 2023/01/26.
//

import UIKit

class WeatherDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(dt: Int, weather: Weather) {
        containerView.backgroundColor = .white
        
        // 角丸
        containerView.layer.cornerRadius = 30
        
        // 枠線
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor(hex: "d9d9d9").cgColor
        
        weatherImageView.image = UIImage(named: Util.getImageNameByWeatherId(id: weather.id))

        let date = NSDate(timeIntervalSince1970: TimeInterval(dt))
        dateLabel.text = (date as Date).Md
        timeLabel.text = "\((date as Date).H)時"
    }
}
