//
//  MainViewModel.swift
//  CityMarks
//
//  Created by André Emiliano on 26/11/2023.
//

import Foundation

class HomeViewModel {
    var cities: [City] = []
    let url = URL(string: "https://6563bf93ceac41c0761d1430.mockapi.io/api/Cities")

    func getMarks(completion: @escaping () -> Void) {
        guard let jsonURL = url else { return }
        URLSession.shared.dataTask(with: jsonURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is Wrong")
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let cities = try decoder.decode([City].self, from: data)
                self.cities = cities
                print(self.cities)
            } catch {
                print(error)
            }
        }.resume()
    }
}
