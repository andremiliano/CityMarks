//
//  MockAPIService.swift
//  CityMarksTests
//
//  Created by André Emiliano on 07/12/2023.
//

import Foundation

class MockAPIService: APIServiceProtocol {
    var shouldSimulateError: Bool = false

    func getCityMarks(completion: @escaping (Result<[City], Error>) -> Void) {
        // Simulate a delay to mimic network latency
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if self.shouldSimulateError {
                let error = NSError(domain: "MockErrorDomain", code: 500, userInfo: nil)
                completion(.failure(error))
            } else {
                let dummyCity1 = City(name: "City1",
                                      country: "Country1",
                                      marks: [
                                        Mark(name: "Mark1",
                                             latitude: 12.0,
                                             longitude: -12.0,
                                             image: "",
                                             description: "This is Mark 1")
                                      ],
                                      id: "1")
                let dummyCity2 = City(name: "City2",
                                      country: "Country2",
                                      marks: [
                                        Mark(name: "Mark1",
                                             latitude: 12.0,
                                             longitude: -12.0,
                                             image: "",
                                             description: "This is Mark 1"),
                                        Mark(name: "Mark2",
                                             latitude: 125.0,
                                             longitude: -125.0,
                                             image: "",
                                             description: "This is Mark 2"),
                                      ],
                                      id: "2")
                let dummyCities = [dummyCity1, dummyCity2]

                completion(.success(dummyCities))
            }
        }
    }
}


