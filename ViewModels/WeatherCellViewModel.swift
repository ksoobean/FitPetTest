//
//  WeatherCellViewModel.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import Foundation
import RxSwift
import RxCocoa


struct WeatherCellViewModel {
    
    let disposeBag = DisposeBag()
    
    let weather: Weather
    
    init(_ weather: Weather) {
        self.weather = weather
    }
}


extension WeatherCellViewModel {
    
    var date: Observable<String> {
        var resultString: String = ""
        
        guard let checkDate = weather.date.toDate(format: "yyyy-MM-dd") else {
            fatalError("Date Formatted error")
        }
        
        let calendar = Calendar.current

        if calendar.isDateInToday(checkDate) {
            resultString = "오늘"
        } else if calendar.isDateInTomorrow(checkDate) {
            resultString = "내일"
        } else {
            resultString = checkDate.toString(format: "EEE d MMM")
        }
        
        return Observable<String>.just(resultString)
    }
    
    var weatherState: Observable<String> {
        return Observable<String>.just(weather.weatherState)
    }
    
    var maxTemperature: Observable<String> {
        return Observable<String>.just("Max:\(Int(weather.maxTemp))℃")
    }
    
    var minTemperature: Observable<String> {
        return Observable<String>.just("Min:\(Int(weather.minTemp))℃")
    }
    
    // 이미지!
    
    var weatherImage: Observable<UIImage?> {
        
        return Observable<UIImage?>.create { emitter in

            guard let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(weather.weatherAbbr).png") else {
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in

                guard let data = data else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }

                let image = UIImage(data: data)
                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
