//
//  APIService.swift
//  CityMarks
//
//  Created by André Emiliano on 29/11/2023.
//

import Foundation

class APIService: NSObject {

    private let sourcesURL = URL(string: "https://6563bf93ceac41c0761d1430.mockapi.io/Cities")

    func getCityMarks(completion: @escaping (Result<[City], Error>) -> Void) {
        guard let jsonURL = sourcesURL else { return }
        URLSession.shared.dataTask(with: jsonURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                return
            }
            do
            {
                let decoder = JSONDecoder()
                let cities = try decoder.decode([City].self, from: data)
                completion(.success((cities)))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
