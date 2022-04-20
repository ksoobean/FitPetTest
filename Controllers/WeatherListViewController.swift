//
//  ViewController.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherListViewController: UITableViewController {
    
    private var weatherListVM = WeatherListViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavi()
        self.configureTableView()
        
        self.fetchWeatherList()
    }

    /// 네비게이션
    private func configureNavi() {
        
        self.title = self.weatherListVM.naviTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        self.tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        self.tableView.register(UINib(nibName: "WeatherListHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "WeatherListHeaderView")
        
    }
    
    /// 리스트 데이터 조회
    private func fetchWeatherList() {
        self.weatherListVM.requestWeather()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }

}

//MARK: - TableViewDatasource
extension WeatherListViewController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherListHeaderView") as? WeatherListHeaderView else {
            fatalError("WeatherListHeaderView is not Exist")
        }
        
        header.headerTitleLabel.text = self.weatherListVM.sectionTitle(at: section)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.weatherListVM.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListVM.numberOfItems(in: section)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            fatalError("WeatherTableViewCell is not Exist")
        }

        let forecast = self.weatherListVM.weatherItem(at: indexPath.section, indexPath.row)
        
        forecast.date.asDriver(onErrorJustReturn: "")
            .drive(cell.dateLabel.rx.text)
            .disposed(by: disposeBag)

        forecast.weatherState.asDriver(onErrorJustReturn: "")
            .drive(cell.weatherStateLabel.rx.text)
            .disposed(by: disposeBag)

        forecast.maxTemperature.asDriver(onErrorJustReturn: "Max: 0℃")
            .drive(cell.maxTempLabel.rx.text)
            .disposed(by: disposeBag)

        forecast.minTemperature.asDriver(onErrorJustReturn: "Min: 0℃")
            .drive(cell.minTempLabel.rx.text)
            .disposed(by: disposeBag)

        // 이미지
        forecast.weatherImage
            .asDriver(onErrorJustReturn: UIImage(systemName: "questionmark.circle")!)
            .drive(cell.weatherImage.rx.image)
            .disposed(by: disposeBag)

        return cell
    }
}
