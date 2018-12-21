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
    private let dataManager: DataManager
    private var cellViewModels = [MainTableCellViewModel]() {
        didSet {
            self.updateView()
        }
    }
    
    // Init
    public init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // Public methods
    public func fetchInitialData() {
        isLoading = true
        var requestCounter = dataManager.cityCodes.count
        self.dataManager.cityCodes.forEach { code in
            self.dataManager.fetchForecast(forCityCode: code) { [weak self] in
                guard let self = self else { return }
                
                requestCounter -= 1
                if requestCounter == 0 {
                    self.updateView()
                    self.separatorStyle = .singleLine
                    self.isLoading = false
                    self.dataManager.cityCollection.forEach { city in
                        self.cellViewModels.append(self.createCellViewModel(city: city))
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
        let city = dataManager.cityCollection[selectedIndex]
        
        return MapViewModel(latitude: city.coordinates.lat,
                            longitude: city.coordinates.lon)
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
