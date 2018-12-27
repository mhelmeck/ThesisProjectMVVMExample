//
//  CitiesListViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class CitiesListViewModel {
    // Public properties
    public var updateView: (() -> Void)!
    public var updateSeparatorStyle: ((SeparatorStyle) -> Void)!
    public var updateActivityIndicator: ((Bool) -> Void)!
    
    public var separatorStyle: SeparatorStyle = .none {
        didSet {
            self.updateSeparatorStyle(separatorStyle)
        }
    }
    public var isLoading = false {
        didSet {
            self.updateActivityIndicator(isLoading)
        }
    }

    public var selectedIndex = 0
    public var rowsNumber: Int {
        return cellViewModels.count
    }
    
    // Private properties
    private let apiManager: CityAPIProvider
    private let repository: CityPersistence
    
    private var cellViewModels = [CityCellViewModel]() {
        didSet {
            self.updateView()
        }
    }
    
    // MARK: - Init
    public init() {
        self.apiManager = APIManager()
        self.repository = AppRepository.shared
    }
    
    // Public methods
    public func fetchInitialData() {
        isLoading = true
        let initialCityCodes = ["44418", "4118", "804365"]
        var requestCounter = initialCityCodes.count
        
        initialCityCodes.forEach {
            self.apiManager.fetchCity(forCode: $0) { [weak self] in
                guard let self = self else { return }

                self.repository.addCity(city: $0)
                requestCounter -= 1
                if requestCounter == 0 {
                    self.updateView()
                    self.separatorStyle = .singleLine
                    self.isLoading = false
                    
                    self.repository.getCities().forEach {
                        self.cellViewModels.append(self.createCellViewModel(city: $0))
                    }
                }
            }
        }
    }
    
    public func userPressedCell(at row: Int) {
        selectedIndex = row
    }
    
    public func userPressedNaviagationButton(at row: Int) {
        selectedIndex = row
    }
    
    public func getCellViewModel(at row: Int) -> CityCellViewModel {
        return cellViewModels[row]
    }
    
    public func getShowMapViewModel() -> ShowMapViewModel {
        let city = repository.getCities()[selectedIndex]
        
        return ShowMapViewModel(latitude: city.coordinates.lat,
                                longitude: city.coordinates.lon)
    }
    
    public func getCityDetailsViewModel() -> CityDetailsViewModel {
        let city = repository.getCities()[selectedIndex]
        
        return CityDetailsViewModel(cityName: city.name,
                                    forecastCollection: city.forecastCollection)
    }
    
    public func getSearchLocationViewModel() -> SearchLocationViewModel {
        return SearchLocationViewModel()
    }
    
    public func reloadData() {
        cellViewModels.removeAll()
        repository.getCities().forEach {
            cellViewModels.append(createCellViewModel(city: $0))
        }
        
        updateView()
    }

    // Private methods
    private func createCellViewModel(city: City) -> CityCellViewModel {
        let temperature = [String(Int(city.brief.currentTemperature)), "°C"].joined(separator: " ")
        let iconName = AssetCodeMapper.map(city.brief.asset)
        
        return CityCellViewModel(cityName: city.name,
                                 temperature: temperature,
                                 iconName: iconName)
    }
}