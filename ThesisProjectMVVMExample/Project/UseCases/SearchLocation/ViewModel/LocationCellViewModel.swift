//
//  LocationCellViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 27/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct LocationCellViewModel {
    public var cityName = ""
    public var cityCode = ""
    
    public init(cityName: String,
                cityCode: String) {
        self.cityName = cityName
        self.cityCode = cityCode
    }
}
