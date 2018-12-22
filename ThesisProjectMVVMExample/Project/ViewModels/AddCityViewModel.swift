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
    private let apiManager: APIManagerType
    private let repository: AppRepositoryType
    
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
    public init() {
        self.apiManager = APIManager()
        self.repository = AppRepository.shared
    }
    
    // MARK: - Public methods
    public func clearData() {
        repository.clearLocations()
    }
    
    public func userPressedSearchButton() {
        guard !phrase.isEmpty else {
            return
        }
        
        apiManager.fetchLocations(withQuery: phrase) { [weak self] in
            guard let self = self else { return }

            self.fetchLocations(locations: $0)
        }
    }
    
    public func userPressedCurrentButton() {
        guard let latitude = currentCoordinates?.lat,
              let longitude = currentCoordinates?.lon else {
                return
        }

        apiManager.fetchLocations(withCoordinate: String(latitude), String(longitude)) { [weak self] in
            guard let self = self else { return }
            
            self.fetchLocations(locations: $0)
        }
    }
    
    public func userPressedCancelButton() {
        closeView()
    }
    
    public func userPressedCell(at row: Int) {
        isSavingNewCity = true
        
        let cellViewModel = addCityCellViewModels[row]
        let cityCode = String(cellViewModel.cityCode)
        
        apiManager.fetchCity(forCode: cityCode) { [weak self] in
            self?.repository.addCity(city: $0)
            
            self?.clearData()
            self?.isSavingNewCity = false
            self?.closeView()
        }
    }
    
    public func updateCurrentLocation(latitude: Double,
                                      longitude: Double) {
        
        apiManager.fetchLocations(withCoordinate: String(latitude), String(longitude)) { [weak self] in
            guard let currentLocation = $0.first else {
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
    
    private func fetchLocations(locations: [Location]) {
        // TODO: - should clear locations?
        locations.forEach {
            repository.addLocation(location: $0)
        }
        
        addCityCellViewModels.removeAll()
        repository.getLocations().forEach {
            addCityCellViewModels.append(createAddCityCellViewModel(location: $0))
        }
        
        updateView()
    }
}
