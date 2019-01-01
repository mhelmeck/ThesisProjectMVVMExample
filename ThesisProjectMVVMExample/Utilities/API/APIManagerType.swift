//
//  APIManagerType.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public typealias DataManagerType = CityProvider & LocationProvider

public protocol CityProvider {
    func fetchCity(forCode code: String, completion: @escaping (City) -> Void)
}

public protocol LocationProvider {
    func fetchLocations(withCoordinate latitude: String,
                        _ longitude: String,
                        completion: @escaping ([Location]) -> Void)
    func fetchLocations(withQuery query: String, completion: @escaping ([Location]) -> Void)
}

public class DataManager: DataManagerType {
    private let apiManager: APIManagerType = APIManager()
    
    public func fetchCity(forCode code: String, completion: @escaping (City) -> Void) {
        apiManager.fetchForecast(forCode: code) {
            let adapter = CityAdapter(apiForecast: $0)
            let city = adapter.toCity()
            
            completion(city)
        }
    }
    
    public func fetchLocations(withCoordinate latitude: String,
                               _ longitude: String,
                               completion: @escaping ([Location]) -> Void) {
        apiManager.fetchParents(withCoordinate: latitude, longitude) {
            let adapter = LocationCollectionAdapter(apiParentCollection: $0)
            let locationCollection = adapter.toLocationCollection()
            
            completion(locationCollection)
        }
    }
    
    public func fetchLocations(withQuery query: String, completion: @escaping ([Location]) -> Void) {
        apiManager.fetchParents(withQuery: query) {
            let adapter = LocationCollectionAdapter(apiParentCollection: $0)
            let locationCollection = adapter.toLocationCollection()
            
            completion(locationCollection)
        }
    }
}

// --------

public typealias APIManagerType = APIForecastProvider & APIParentProvider

public protocol APIForecastProvider {
    func fetchForecast(forCode code: String, completion: @escaping (APIForecast) -> Void)
}

public protocol APIParentProvider {
    func fetchParents(withCoordinate latitude: String,
                      _ longitude: String,
                      completion: @escaping ([APIParent]) -> Void)
    func fetchParents(withQuery query: String, completion: @escaping ([APIParent]) -> Void)
}
