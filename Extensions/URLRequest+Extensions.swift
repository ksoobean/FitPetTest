//
//  URLRequest+Extensions.swift
//  FitPetTest
//
//  Created by 김수빈 on 2022/04/19.
//

import Foundation
import RxSwift
import RxCocoa


struct Resource<T: Decodable> {
    let url: URL
    
    init(urlString: String) {
        guard let url = URL(string: urlString) else {
            fatalError("URL Error")
        }
        self.url = url
    }
}

extension URLRequest {
    
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
}
