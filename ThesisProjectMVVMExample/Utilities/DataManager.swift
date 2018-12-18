//
//  File4.swift
//  ThesisProjectMVVMExample
//
//  Created by Maciej Hełmecki on 18/12/2018.
//  Copyright © 2018 Maciej Hełmecki. All rights reserved.
//

import Foundation

public class DataManager {
    // Properties
    public var cityCodes: [String] = ["44418", "4118", "804365"] // Get rid of this
    public var locationCollection = [Location]()
    public var cityCollection = [City]()
    
    // Public methods
    public func fetchForecast(forCityCode code: String, completion: @escaping () -> Void) {
        let urlString = "https://www.metaweather.com/api/location/\(code)/"
        
        fetchData(withURLString: urlString) { (result: APIResult<APIForecast>) in
            switch result {
            case .error(let error):
                print("Error: \(error)")
            case .success(let result):
                let adapter = CityAdapter(apiForecast: result)
                let city = adapter.toCity()
                
                if !self.cityCodes.contains(city.code) {
                    self.cityCodes.append(city.code)
                }
                
                let duplications = self.cityCollection.filter { $0.code == city.code }
                if duplications.isEmpty {
                    self.cityCollection.append(city)
                }
                
                completion()
            }
        }
    }
    
    public func fetchLocation(withLatLon lat: String, _ lon: String, completion: @escaping ([APIParent]) -> Void) {
        let urlString = "https://www.metaweather.com/api/location/search/?lattlong=\(lat),\(lon)"
        fetchData(withURLString: urlString) { (result: APIResult<[APIParent]>) in
            switch result {
            case .error(let error):
                print("Error: \(error)")
            case .success(let result):
                completion(result)
            }
        }
    }
    
    public func fetchLocations(withQuery query: String, completion: @escaping () -> Void) {
        let formattedQuery = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://www.metaweather.com/api/location/search/?query=\(formattedQuery)"
        
        fetchLocations(withURLString: urlString, completion: completion)
    }
    
    public func fetchLocations(withLatLon lat: String, _ lon: String, completion: @escaping () -> Void) {
        let urlString = "https://www.metaweather.com/api/location/search/?lattlong=\(lat),\(lon)"
        
        fetchLocations(withURLString: urlString, completion: completion)    }
    
    // Private methods
    private func fetchLocations(withURLString urlString: String, completion: @escaping () -> Void) {
        fetchData(withURLString: urlString) { (result: APIResult<[APIParent]>) in
            switch result {
            case .error(let error):
                print("Error: \(error)")
            case .success(let result):
                let adapter = LocationCollectionAdapter(apiParentCollection: result)
                let locationCollection = adapter.toLocationCollection()
                
                self.locationCollection = locationCollection
                completion()
            }
        }
    }
    
    private func fetchData<T: Decodable>(withURLString urlString: String, completion: @escaping APIResultHandler<T>) {
        guard let url = URL(string: urlString) else {
            completion(.error(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard let data = data else {
                completion(.error(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let error {
                completion(.error(error))
            }
        }.resume()
    }
}
