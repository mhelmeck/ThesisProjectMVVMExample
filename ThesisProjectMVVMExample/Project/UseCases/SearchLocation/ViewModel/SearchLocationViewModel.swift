//
//  SearchLocationViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 22/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class SearchLocationViewModel {
    // MARK: - Public properties
    public var updateCurrentButton: ((Bool) -> Void)!
    public var updateLoadingState: ((Bool) -> Void)!
    public var updateView: (() -> Void)!
    public var closeView: (() -> Void)!
    public var updateTitle: ((String) -> Void)!
    
    public var phrase = ""
    public var rowsNumber: Int {
        return locationCellViewModels.count
    }
    
    // MARK: - Private properties
    private let dataManager: DataManagerType
    private let repository: AppRepositoryType
    
    private var currentCoordinates: Coordinates?
    private var locationCellViewModels = [LocationCellViewModel]() {
        didSet {
            self.updateView()
        }
    }

    private var isLoading = false {
        didSet {
            self.updateLoadingState(isLoading)
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
        self.dataManager = DataManager()
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
        
        dataManager.fetchLocations(withQuery: phrase) { [weak self] in
            guard let self = self else {
                return
            }

            self.fetchLocations(locations: $0)
        }
    }
    
    public func userPressedCurrentButton() {
        guard let latitude = currentCoordinates?.latitude,
              let longitude = currentCoordinates?.longitude else {
                return
        }

        dataManager.fetchLocations(withCoordinate: String(latitude), String(longitude)) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.fetchLocations(locations: $0)
        }
    }
    
    public func userPressedCancelButton() {
        closeView()
    }
    
    public func userPressedCell(at row: Int) {
        isLoading = true
        
        let cellViewModel = locationCellViewModels[row]
        let cityCode = String(cellViewModel.cityCode)
        
        dataManager.fetchCity(forCode: cityCode) { [weak self] in
            self?.repository.addCity(city: $0)
            
            self?.clearData()
            self?.isLoading = false
            self?.closeView()
        }
    }
    
    public func updateCurrentLocation(latitude: Double,
                                      longitude: Double) {
        
        dataManager.fetchLocations(withCoordinate: String(latitude), String(longitude)) { [weak self] in
            guard let currentLocation = $0.first else {
                return
            }

            self?.currentCoordinates = currentLocation.coordinates
            self?.title = "Your current location is: \(currentLocation.name)"
            self?.isCurrentButtonEnabled = true
        }
    }
    
    public func getLocationCellViewModel(at row: Int) -> LocationCellViewModel {
        return locationCellViewModels[row]
    }
    
    // MARK: - Private methods
    private func createLocationCellViewModel(location: Location) -> LocationCellViewModel {
        return LocationCellViewModel(cityName: location.name,
                                     cityCode: location.code)
    }
    
    private func fetchLocations(locations: [Location]) {
        repository.clearLocations()
        locations.forEach {
            repository.addLocation(location: $0)
        }
        
        locationCellViewModels.removeAll()
        repository.getLocations().forEach {
            locationCellViewModels.append(createLocationCellViewModel(location: $0))
        }
        
        updateView()
    }
}
