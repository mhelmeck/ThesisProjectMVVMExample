//
//  File.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

//swiftlint:disable identifier_name
public struct APIConsolidatedWeather: Codable {
    public let id: Int
    public let weatherStateName: String
    public let weatherStateAbbr: String
    public let windDirectionCompass: String
    public let created: String
    public let applicableDate: String
    public let minTemp: Double
    public let maxTemp: Double
    public let theTemp: Double
    public let windSpeed: Double
    public let windDirection: Double
    public let airPressure: Double
    public let humidity: Int
    public let visibility: Double
    public let predictability: Int
    
    public enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity, visibility, predictability
    }
}
