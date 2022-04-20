//
//  WeatherTableViewCell.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.font = .systemFont(ofSize: 20)
        dateLabel.textColor = .darkGray
        
        weatherStateLabel.font = .systemFont(ofSize: 15)
        weatherStateLabel.textColor = .darkGray
        
        maxTempLabel.font = .systemFont(ofSize: 15)
        maxTempLabel.textColor = .darkGray
        
        minTempLabel.font = .systemFont(ofSize: 15)
        minTempLabel.textColor = .darkGray
        
        weatherImage.image = nil
    }

    
}
