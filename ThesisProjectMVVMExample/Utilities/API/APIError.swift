//
//  APIError.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public enum APIError: Error {
    case didFailToDecode
    case noData
    case invalidURL
}
