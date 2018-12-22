//
//  DetailViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class DetailViewModel {
    // MARK: - Public properties
    public var updatePreviewButton: ((Bool) -> Void)!
    public var updateNextButton: ((Bool) -> Void)!
    public var updateForecastView: ((ForecastViewModel) -> Void)!
    
    public var isLoaded = false
    public var cityName: String
    
    // MARK: - Private properties
    private var forecastCollection: [Forecast]
    
    public var forecastIndex: Int = 0 {
        didSet {
            handleButtons(at: forecastIndex)
            createForecastViewModel(at: forecastIndex)
        }
    }
    
    private var isPreviewButtonEnabled = false {
        didSet {
            updatePreviewButton(isPreviewButtonEnabled)
        }
    }
    
    private var isNextButtonEnabled = false {
        didSet {
            updateNextButton(isNextButtonEnabled)
        }
    }
    
    private var forecastViewModel: ForecastViewModel! {
        didSet {
            updateForecastView(forecastViewModel)
        }
    }
    
    // MARK: - Init
    public init(cityName: String,
                forecastCollection: [Forecast]) {
        self.cityName = cityName
        self.forecastCollection = forecastCollection
    }
    
    // MARK: - Public methods
    public func userPressedButton(buttonType: ButtonType) {
        switch buttonType {
        case .preview:
            forecastIndex -= 1
        case .next:
            forecastIndex += 1
        }
    }
    
    // MARK: - Private methods
    private func handleButtons(at forecastIndex: Int) {
        if forecastIndex == 0 {
            isPreviewButtonEnabled = false
            if forecastIndex != forecastCollection.count - 1 {
                isNextButtonEnabled = true
            }
        }

        if forecastIndex == forecastCollection.count - 1 {
            isNextButtonEnabled = false
            if forecastIndex != 0 {
                isPreviewButtonEnabled = true
            }
        }

        if forecastIndex > 0 && forecastIndex < forecastCollection.count - 1 {
            isPreviewButtonEnabled = true
            isNextButtonEnabled = true
        }
    }
    
    private func createForecastViewModel(at forecastIndex: Int) {
        let forecast = forecastCollection[forecastIndex]
        let iconName = AssetCodeMapper.map(forecast.assetCode)
        let typeTextValue = forecast.type
        let minTempTextValue = [String(Int(forecast.minTemperature)), "°C"].joined(separator: " ")
        let maxTempTextValue = [String(Int(forecast.maxTemperature)), "°C"].joined(separator: " ")
        let windSpeedTextValue = [String(Int(forecast.windSpeed)), "m/s"].joined(separator: " ")
        let windDirectionTextValue = forecast.windDirection
        let pressureTextValue = [String(Int(forecast.airPressure)), "hPa"].joined(separator: " ")
        var rainfallTextValue = ""
        switch forecast.assetCode {
        case "h", "hr", "lr", "s", "t":
            rainfallTextValue = "It's raining"
        default:
            rainfallTextValue = "It's not raining"
        }
        
        forecastViewModel = ForecastViewModel(iconName: iconName,
                                              typeTextValue: typeTextValue,
                                              minTempTextValue: minTempTextValue,
                                              maxTempTextValue: maxTempTextValue,
                                              windSpeedTextValue: windSpeedTextValue,
                                              windDirectionTextValue: windDirectionTextValue,
                                              rainfallTextValue: rainfallTextValue,
                                              pressureTextValue: pressureTextValue)
    }
}
