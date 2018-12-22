//
//  APIResult.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public enum APIResult<T> {
    case success(T)
    case error(Error)
}

public typealias APIResultHandler<T> = (APIResult<T>) -> Void
