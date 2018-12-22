//
//  MapViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct MapViewModel {
    public var latitude: Double
    public var longitude: Double
    
    public var latitudeDelta = 0.7
    public var longitudeDelta = 0.7
    
    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
