//
//  MainViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import Foundation

class HomeViewModel: NSObject {
    private var apiService : APIService!
    var onSuccess : (([City]) -> Void)?
    var onErrorHandling : ((Error) -> Void)?

    override init() {
        super.init()
        self.apiService = APIService()
    }

    func getCitiesData() {
        self.apiService.getCityMarks { [weak self] result in
            switch result {
            case .success(let cities):
                DispatchQueue.main.async {
                    self?.onSuccess?(cities)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorHandling?(error)
                }
            }
        }
    }
}
