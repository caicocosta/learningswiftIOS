//
//  REST.swift
//  Carangas
//
//  Created by Caico Saler Oliveira Costa on 09/11/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}

class REST {
    private static let basePath = "https://carangas.herokuapp.com/cars"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        let dataTaks = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
          
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {
                    onError(.noData)
                    return
                }
                if response.statusCode == 200 {
                    
                    guard let data = data else {
                        onError(.invalidJson)
                        return
                    }
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        onError(.invalidJson)
                    }
                    
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTaks.resume()
    }
    
    class func save(car: Car, onComplete: @escaping (Bool) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }

        request.httpBody = json
        
        let dataTaks = session.dataTask(with: request) { data, response, error in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    onComplete(false)
                    return
                }
                
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        
        dataTaks.resume()
    }
    
    class func update(car: Car, onComplete: @escaping (Bool) -> Void) {
        
        let urlString = basePath + "/\(car._id!)"
        
        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }

        request.httpBody = json
        
        let dataTaks = session.dataTask(with: request) { data, response, error in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {
                    onComplete(false)
                    return
                }
                
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        
        dataTaks.resume()
    }
}
