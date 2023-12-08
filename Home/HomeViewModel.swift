//
//  MainViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import Foundation

class HomeViewModel: NSObject {

    private var apiService: APIServiceProtocol

    var selectedCity: City?
    var onSuccess : (([City]) -> Void)?
    var onErrorHandling : ((Error) -> Void)?

    var cityName: String {
        return selectedCity?.name ?? ""
    }

    var countryName: String {
        return selectedCity?.country ?? ""
    }

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func getCitiesData() {
        apiService.getCityMarks { [weak self] result in
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

    func numberOfMarks() -> Int {
        return selectedCity?.marks.count ?? 0
    }

    func didSelectCity(at index: Int) -> Mark? {
        return selectedCity?.marks[index]
    }

    func selectedMark(at index: Int) -> Mark? {
        return selectedCity?.marks[index]
    }
}
