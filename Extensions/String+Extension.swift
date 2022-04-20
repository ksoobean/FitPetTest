//
//  String+Extension.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/20.
//

import Foundation

extension String {
    
    func toDate(format: String) -> Date? {
        //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
            
        }
        
    }
    
}
