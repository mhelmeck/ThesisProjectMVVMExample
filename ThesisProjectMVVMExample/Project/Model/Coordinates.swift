//
//  Coordinates.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct Coordinates: Equatable {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double,
                longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
