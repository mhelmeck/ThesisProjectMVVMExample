//
//  DataManagerType.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 01/01/2019.
//  Copyright © 2019 Maciej Hełmecki. All rights reserved.
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
