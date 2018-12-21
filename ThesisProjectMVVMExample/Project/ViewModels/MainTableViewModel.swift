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
    public var shouldActivityIndicatorAnimate = false {
        didSet {
            self.updateActivityIndicator(shouldActivityIndicatorAnimate)
        }
    }

    public var selectedIndex = 0
    public var rowHeight: Float = 60.0
    public var amountOfCityCollection: Int {
        return dataManager.cityCollection.count
    }
    
    // Private properties
    private let dataManager: DataManager
    
    // Init
    public init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // Public methods
    public func fetchInitialData() {
        shouldActivityIndicatorAnimate = true
        var requestCounter = dataManager.cityCodes.count
        self.dataManager.cityCodes.forEach { code in
            self.dataManager.fetchForecast(forCityCode: code) { [weak self] in
                requestCounter -= 1
                if requestCounter == 0 {
                    self?.updateView()
                    self?.separatorStyle = .singleLine
                    self?.shouldActivityIndicatorAnimate = false
                }
            }
        }
    }
    
    public func getCityWithIndex(_ index: Int) -> City {
        return dataManager.cityCollection[index]
    }
}
