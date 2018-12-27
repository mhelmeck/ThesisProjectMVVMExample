//
//  CityAdapter.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct CityAdapter {
    private let apiForecast: APIForecast
    
    public init(apiForecast: APIForecast) {
        self.apiForecast = apiForecast
    }
    
    public func toCity() -> City {
        guard let firstWeather = apiForecast.consolidatedWeather.first else {
            fatalError("Fatal Error")
        }
        
        let adapter = ForecastCollectionAdapter(consolidatedWeatherCollection: apiForecast.consolidatedWeather)
        return City(code: String(apiForecast.parent.woeid),
                    name: apiForecast.title,
                    coordinates: CoordinatesAdapter(latLon: apiForecast.lattLong).toCoordinates(),
                    brief: City.Brief(currentTemperature: firstWeather.theTemp, asset: firstWeather.weatherStateAbbr),
                    forecastCollection: adapter.toForecastCollection())
    }
}
