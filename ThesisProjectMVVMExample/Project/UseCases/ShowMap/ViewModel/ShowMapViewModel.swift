//
//  ShowMapViewModel.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 21/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct ShowMapViewModel {
    public var coordinates: Coordinates
    
    public init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
}
