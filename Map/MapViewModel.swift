//
//  MapViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 30/11/2023.
//

import Foundation

class MapViewModel: NSObject {
    private var apiService : APIService!
    var onSuccess : (([Mark]) -> Void)?
    var onErrorHandling : ((Error) -> Void)?

    override init() {
        super.init()
        self.apiService = APIService()
    }

    func getCitiesData() {
        self.apiService.getCityMarks { [weak self] result in
            switch result {
            case .success(let cities):
                let marks = cities.flatMap({ $0.marks })
                DispatchQueue.main.async {
                    self?.onSuccess?(marks)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorHandling?(error)
                }
            }
        }
    }
}
