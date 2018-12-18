//
//  File3.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct Forecast: Equatable {
    public let type: String
    public let assetCode: String
    public let windDirection: String
    public let date: String
    public let minTemperature: Double
    public let maxTemperature: Double
    public let currentTemperature: Double
    public let windSpeed: Double
    public let airPressure: Double
    
    public init(type: String,
                assetCode: String,
                windDirection: String,
                date: String,
                minTemperature: Double,
                maxTemperature: Double,
                currentTemperature: Double,
                windSpeed: Double,
                airPressure: Double) {
        self.type = type
        self.assetCode = assetCode
        self.windDirection = windDirection
        self.date = date
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.currentTemperature = currentTemperature
        self.windSpeed = windSpeed
        self.airPressure = airPressure
    }
}
