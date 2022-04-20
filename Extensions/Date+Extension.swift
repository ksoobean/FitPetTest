//
//  Date+Extension.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/20.
//

import Foundation

extension Date {
    
    
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "en")
        return dateFormatter.string(from: self)
        
    }
    
}
