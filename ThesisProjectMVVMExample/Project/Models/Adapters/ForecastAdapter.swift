//
//  ForecastAdapter.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct ForecastAdapter {
    private let consolidatedWeather: APIConsolidatedWeather
    
    public init(consolidatedWeather: APIConsolidatedWeather) {
        self.consolidatedWeather = consolidatedWeather
    }
    
    public func toForecastCollection() -> Forecast {
        return Forecast(type: consolidatedWeather.weatherStateName,
                        assetCode: consolidatedWeather.weatherStateAbbr,
                        windDirection: consolidatedWeather.windDirectionCompass,
                        date: consolidatedWeather.applicableDate,
                        minTemperature: consolidatedWeather.minTemp,
                        maxTemperature: consolidatedWeather.maxTemp,
                        currentTemperature: consolidatedWeather.theTemp,
                        windSpeed: consolidatedWeather.windSpeed,
                        airPressure: consolidatedWeather.airPressure)
    }
}
