//
//  LocationAdapter.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct LocationAdapter {
    private let apiParent: APIParent
    
    public init(apiParent: APIParent) {
        self.apiParent = apiParent
    }
    
    public func toLocation() -> Location {
        return Location(code: String(apiParent.woeid),
                        name: apiParent.title,
                        type: apiParent.locationType,
                        coordinates: CoordinatesAdapter(latLon: apiParent.lattLong).toCoordinates())
    }
}
