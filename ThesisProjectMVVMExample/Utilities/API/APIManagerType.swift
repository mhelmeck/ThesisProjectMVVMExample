//
//  APIManagerType.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

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
