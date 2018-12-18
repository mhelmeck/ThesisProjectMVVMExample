//
//  File2.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct Coordinates: Equatable {
    public let lat: Double
    public let lon: Double
    
    public init(lat: Double,
                lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
