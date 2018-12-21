//
//  MainTableCellViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public class MainTableCellViewModel {
    // ViewProperties
    public var cityName: String = ""
    public var temp: String = ""
    public var iconImageName: String = ""
    
    // ModelProperty to be injected
    private let city: City
    
    // Init
    public init(city: City) {
        self.city = city
        
        configureCell()
    }
    
    public func configureCell() {
        cityName = city.name
        temp = [String(Int(city.brief.currentTemperature)), "°C"].joined(separator: " ")
        iconImageName = AssetCodeMapper.map(city.brief.asset)
    }
}
