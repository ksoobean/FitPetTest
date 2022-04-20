//
//  WeatherListHeaderView.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/20.
//

import UIKit

class WeatherListHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerTitleLabel.font = .boldSystemFont(ofSize: 22)
        headerTitleLabel.textColor = .darkGray
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
}
