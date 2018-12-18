//
//  File.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct City: Equatable {
    public let code: String
    public let name: String
    public let coordinates: Coordinates
    public let brief: Brief
    public let forecastCollection: [Forecast]
    
    public struct Brief: Equatable {
        public let currentTemperature: Double
        public let asset: String
    }
    
    public init(code: String,
                name: String,
                coordinates: Coordinates,
                brief: Brief,
                forecastCollection: [Forecast]) {
        self.code = code
        self.name = name
        self.coordinates = coordinates
        self.brief = brief
        self.forecastCollection = forecastCollection
    }
}
