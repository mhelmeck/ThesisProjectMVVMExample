//
//  AssetCodeMapper.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import Foundation

//swiftlint:disable cyclomatic_complexity
public struct AssetCodeMapper {
    public static func map(_ code: String) -> String {
        switch code {
        case "sn":
            return "snow"
        case "sl":
            return "sleet"
        case "h":
            return "hail"
        case "t":
            return "thunderstorm"
        case "hr":
            return "heavy_rain"
        case "lr":
            return "light_rain"
        case "s":
            return "showers"
        case "hc":
            return "heavy_cloud"
        case "lc":
            return "light_cloud"
        case "c":
            return "clear"
        default:
            return "clear"
        }
    }
}
