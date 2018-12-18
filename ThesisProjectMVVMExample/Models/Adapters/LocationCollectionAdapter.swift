//
//  File6.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

public struct LocationCollectionAdapter {
    private let apiParentCollection: [APIParent]
    
    public init(apiParentCollection: [APIParent]) {
        self.apiParentCollection = apiParentCollection
    }
    
    public func toLocationCollection() -> [Location] {
        var locationCollection = [Location]()
        apiParentCollection.forEach {
            let adapter = LocationAdapter(apiParent: $0)
            locationCollection.append(adapter.toLocation())
        }
        
        return locationCollection
    }
}
