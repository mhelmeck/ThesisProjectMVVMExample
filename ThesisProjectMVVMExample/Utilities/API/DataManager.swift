//
//  DataManager.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 01/01/2019.
//  Copyright © 2019 Maciej Hełmecki. All rights reserved.
//

import Foundation

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
