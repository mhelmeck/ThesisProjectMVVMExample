//
//  Repository.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class AppRepository: AppRepositoryType {
    // MARK: - Public properties
    public static let shared = AppRepository()
    
    // MARK: - Private properties
    private var locationCollection = [Location]()
    private var cityCollection = [City]()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Public methods
    public func addCity(city: City) {
        if !cityCollection.contains(city) {
            cityCollection.append(city)
        }
    }
    
    public func getCities() -> [City] {
        return cityCollection
    }
    
    public func clearCities() {
        cityCollection.removeAll()
    }
    
    public func addLocation(location: Location) {
        if !locationCollection.contains(location) {
            locationCollection.append(location)
        }
    }
    
    public func getLocations() -> [Location] {
        return locationCollection
    }
    
    public func clearLocations() {
        locationCollection.removeAll()
    }
}
