//
//  CoordinatesAdapter.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct CoordinatesAdapter {
    private let latLon: String
    
    public init(latLon: String) {
        self.latLon = latLon
    }
    
    public func toCoordinates() -> Coordinates {
        let formattedStringLatLon = latLon.replacingOccurrences(of: " ", with: "")
        let stringLatLon = formattedStringLatLon.split(separator: ",")
        guard let lat = Double(stringLatLon[0]), let lon = Double(stringLatLon[1])  else {
            fatalError("Adaptation to coordinates failed")
        }
        
        return Coordinates(lat: lat, lon: lon)
    }
}
