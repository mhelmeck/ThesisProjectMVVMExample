//
//  File4.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct Location: Equatable {
    public let code: String
    public let name: String
    public let type: String
    public let coordinates: Coordinates
    
    public init(code: String,
                name: String,
                type: String,
                coordinates: Coordinates) {
        self.code = code
        self.name = name
        self.type = type
        self.coordinates = coordinates
    }
}
