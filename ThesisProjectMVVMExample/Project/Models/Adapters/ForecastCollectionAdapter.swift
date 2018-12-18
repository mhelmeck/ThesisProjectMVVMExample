//
//  File4.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct ForecastCollectionAdapter {
    private let consolidatedWeatherCollection: [APIConsolidatedWeather]
    
    public init(consolidatedWeatherCollection: [APIConsolidatedWeather]) {
        self.consolidatedWeatherCollection = consolidatedWeatherCollection
    }
    
    public func toForecastCollection() -> [Forecast] {
        var forecastCollection = [Forecast]()
        consolidatedWeatherCollection.forEach {
            let adapter = ForecastAdapter(consolidatedWeather: $0)
            forecastCollection.append(adapter.toForecastCollection())
        }
        
        return forecastCollection
    }
}
