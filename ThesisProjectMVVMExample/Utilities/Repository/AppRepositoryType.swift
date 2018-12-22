//
//  AppRepositoryType.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public typealias AppRepositoryType = CityPersistence & LocationPersistence

public protocol CityPersistence {
    func addCity(city: City)
    func getCities() -> [City]
    func clearCities()
}

public protocol LocationPersistence {
    func addLocation(location: Location)
    func getLocations() -> [Location]
    func clearLocations()
}
