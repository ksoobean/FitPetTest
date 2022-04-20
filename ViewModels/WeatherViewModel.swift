//
//  WeatherListViewModel.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import Foundation
import RxSwift
import RxRelay

struct WeatherTableDataModel {
    let sectionTitle: String
    let sectionItems: [WeatherCellViewModel]
}

struct WeatherListViewModel {
    
    let naviTitle: String = "Weather Forecast"
    
    private var listData = BehaviorRelay<[WeatherTableDataModel]>(value: [])
    
    let disposeBag = DisposeBag()
}

extension WeatherListViewModel {
    
    /// 도시 정보로 날씨 데이터 요청
    func requestWeather() -> Observable<[WeatherTableDataModel]> {
        self.requestCityInfo()
            .subscribe(onNext: { cities in
                
                guard let city = cities.first else {
                    return
                }
                let forecastRequestURL = "https://www.metaweather.com/api/location/\(city.woeid)/"
                let resource = Resource<WeatherResponse>(urlString: forecastRequestURL)
                URLRequest.load(resource: resource)
                    .subscribe(onNext: { [self] response in
                        
                        var temp = self.listData.value
                        temp.append(WeatherTableDataModel(sectionTitle: city.title, sectionItems: response.weatherForecast.compactMap { WeatherCellViewModel($0) }))
                        self.listData.accept(temp)
                        
                    }).disposed(by: disposeBag)
            }).disposed(by: disposeBag)
        
        return  self.listData.asObservable()
    }
    
    /// 날씨를 확인할 도시 woeid, name 요청
    private func requestCityInfo() -> Observable<[City]> {
        return Observable.from(SearchCity.allCases.enumerated())
            .flatMap { index, item -> Observable<[City]> in
                let woeIdRequestURL = "https://www.metaweather.com/api/location/search/?query=\(item.rawValue)"
                
                let resource = Resource<[City]>(urlString: woeIdRequestURL)
                return URLRequest.load(resource: resource)
            }.asObservable()
    }
    
}

extension WeatherListViewModel {
    
    /// 셀 아이템
    func weatherItem(at section: Int, _ index: Int) -> WeatherCellViewModel {
        return self.listData.value[section].sectionItems[index]
    }
    
    /// 섹션 타이틀
    func sectionTitle(at section: Int) -> String {
        return self.listData.value[section].sectionTitle
    }
    
    /// 섹션 갯수
    func numberOfSections() -> Int {
        return self.listData.value.count
    }
    
    /// 섹션 내의 아이템 갯수
    func numberOfItems(in section: Int) -> Int {
        return self.listData.value[section].sectionItems.count
    }
}
