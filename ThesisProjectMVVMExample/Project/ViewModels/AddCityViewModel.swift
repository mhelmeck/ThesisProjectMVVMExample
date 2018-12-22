//
//  AddCityViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct AddCityCellViewModel {
    public var cityName = ""
    public var cityCode = ""
    
    public init(cityName: String,
                cityCode: String) {
        self.cityName = cityName
        self.cityCode = cityCode
    }
}

public class AddCityViewModel {
    // MARK: - Public properties
    public var updateCurrentButton: ((Bool) -> Void)!
    public var updateIsSavingNewCity: ((Bool) -> Void)!
    public var updateView: (() -> Void)!
    public var closeView: (() -> Void)!
    public var updateTitle: ((String) -> Void)!
    
    public var phrase = ""
    public var rowsNumber: Int {
        return addCityCellViewModels.count
    }
    
    // MARK: - Private properties
    private let dataManager: DataManager
    private var currentCoordinates: Coordinates?
    private var addCityCellViewModels = [AddCityCellViewModel]() {
        didSet {
            self.updateView()
        }
    }

    private var isSavingNewCity = false {
        didSet {
            self.updateIsSavingNewCity(isSavingNewCity)
        }
    }
    
    private var isCurrentButtonEnabled = false {
        didSet {
            updateCurrentButton(isCurrentButtonEnabled)
        }
    }
    
    private var title = "" {
        didSet {
            updateTitle(title)
        }
    }
    
    // MARK: - Init
    public init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // MARK: - Public methods
    public func clearData() {
        dataManager.locationCollection.removeAll()
    }
    
    public func userPressedSearchButton() {
        guard !phrase.isEmpty else {
            return
        }
        
        dataManager.fetchLocations(withQuery: phrase) { [weak self] in
            guard let self = self else { return }
            
            self.fetchLocations()
        }
    }
    
    public func userPressedCurrentButton() {
        guard let latitude = currentCoordinates?.lat,
              let longitude = currentCoordinates?.lon else {
                return
        }

        dataManager.fetchLocations(withLatLon: String(latitude), String(longitude)) { [weak self] in
            guard let self = self else { return }
            
            self.fetchLocations()
        }
    }
    
    public func userPressedCancelButton() {
        closeView()
    }
    
    public func userPressedCell(at row: Int) {
        isSavingNewCity = true
        
        let cellViewModel = addCityCellViewModels[row]
        let cityCode = String(cellViewModel.cityCode)
        
        dataManager.fetchForecast(forCityCode: cityCode) { [weak self] in
            self?.clearData()
            self?.isSavingNewCity = false
            self?.closeView()
        }
    }
    
    public func updateLocation(latitude: Double,
                               longitude: Double) {
        
        dataManager.fetchLocation(withLatLon: String(latitude), String(longitude)) { [weak self] locations in
            guard let currentLocation = locations.first else {
                return
            }

            self?.currentCoordinates = currentLocation.coordinates
            self?.title = "Your current location is: \(currentLocation.name)"
            self?.isCurrentButtonEnabled = true
        }
    }
    
    public func getAddCityCellViewModel(at row: Int) -> AddCityCellViewModel {
        return addCityCellViewModels[row]
    }
    
    // MARK: - Private methods
    private func createAddCityCellViewModel(location: Location) -> AddCityCellViewModel {
        return AddCityCellViewModel(cityName: location.name,
                                    cityCode: location.code)
    }
    
    private func fetchLocations() {
        addCityCellViewModels.removeAll()
        dataManager.locationCollection.forEach { location in
            addCityCellViewModels.append(createAddCityCellViewModel(location: location))
        }
        updateView()
    }
}