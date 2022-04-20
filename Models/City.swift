//
//  City.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import Foundation

enum SearchCity: String, CaseIterable {
    case Seoul
    case London
    case Chicago
}


struct City: Decodable {
    let title: String // "London"
    let woeid: Int // 44418
}
