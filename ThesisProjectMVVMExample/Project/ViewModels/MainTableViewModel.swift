//
//  MainTableViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class MainTableViewModel {
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
    public var rowHeight: Float = 60.0
    public var rowsNumber: Int {
        return cellViewModels.count
    }
    
    // Private properties
    private let apiManager: CityAPIProvider
    private let repository: CityPersistence
    
    private var cellViewModels = [MainTableCellViewModel]() {
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
    
    public func userPressedNaviagationButton(at row: Int?) {
        selectedIndex = row ?? 0
    }
    
    public func getCellViewModel(at row: Int) -> MainTableCellViewModel {
        return cellViewModels[row]
    }
    
    public func getMapViewModel() -> MapViewModel {
        let city = repository.getCities()[selectedIndex]
        
        return MapViewModel(latitude: city.coordinates.lat,
                            longitude: city.coordinates.lon)
    }
    
    public func getDetailViewModel() -> DetailViewModel {
        let city = repository.getCities()[selectedIndex]
        
        return DetailViewModel(cityName: city.name,
                               forecastCollection: city.forecastCollection)
    }
    
    public func getAddCityViewModel() -> AddCityViewModel {
        return AddCityViewModel()
    }
    
    public func reloadData() {
        cellViewModels.removeAll()
        repository.getCities().forEach {
            cellViewModels.append(createCellViewModel(city: $0))
        }
        
        updateView()
    }

    // Private methods
    private func createCellViewModel(city: City) -> MainTableCellViewModel {
        let temperature = [String(Int(city.brief.currentTemperature)), "°C"].joined(separator: " ")
        let iconName = AssetCodeMapper.map(city.brief.asset)
        
        return MainTableCellViewModel(cityName: city.name,
                                      temperature: temperature,
                                      iconName: iconName)
    }
}
