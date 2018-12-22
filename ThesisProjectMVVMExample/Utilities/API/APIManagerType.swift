//
//  APIManagerType.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public typealias APIManagerType = CityAPIProvider & LocationAPIProvider

public protocol CityAPIProvider {
    func fetchCity(forCode code: String, completion: @escaping (City) -> Void)
}

public protocol LocationAPIProvider {
    func fetchLocations(withCoordinate latitude: String,
                        _ longitude: String,
                        completion: @escaping ([Location]) -> Void)
    func fetchLocations(withQuery query: String, completion: @escaping ([Location]) -> Void)
}
