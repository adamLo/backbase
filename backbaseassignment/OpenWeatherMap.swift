//
//  OpenWeatherMap.swift
//  backbaseassignment
//
//  Created by Adam Lovastyik on 03/11/2018.
//  Copyright © 2018 Adam Lovastyik. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class OpenWeatherMap {
    
    static let shared = OpenWeatherMap()
    
    typealias SendCompletionBlockType = ((_ results: [String: Any]?, _ error: Error?) -> ())
    
    private struct Configuration {
        
        static let apiKey   = "c6e381d8c7ff98f0fee43775817cf6ad"
        static let baseURL  = URL(string: "http://api.openweathermap.org/data/2.5")!
        
        static let weather  = "weather"
        static let appid    = "appid"
        static let lat      = "lat"
        static let lon      = "lon"
        static let units    = "units"
        static let metric   = "metric"
    }
    
    private lazy var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    // MARK: - Queries
    
    private func send(request urlRequest: URLRequest, completion: SendCompletionBlockType?) {
        
        (UIApplication.shared.delegate as! AppDelegate).showNetworkIndicator()
        
        let dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            var httpCode = HTTPStatusCode.unknown
            
            if let responseData = response as? HTTPURLResponse {
                
                httpCode = responseData.statusCode
            }
            
            #if DEBUG
            
            let dataString = data != nil ? String(data: data!, encoding: .utf8) : "EMPTY"
            print("\(urlRequest.httpMethod!) \(urlRequest.url!) -> \(httpCode)\n\(dataString ?? "EMPTY"), error: \(String(describing: error))")
            #endif
            
            DispatchQueue.main.async {
                
                (UIApplication.shared.delegate as! AppDelegate).hideNetworkIndicator()
            }
            
            if error != nil {
                
                completion?(nil, error)
            }
            else if !HTTPStatusCode.okCodes.contains(httpCode) {
                
                var errorMessage = "Unknown error"
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    
                    if let errorCode = json["error"] as? Int {
                        
                        errorMessage = "Error: \(errorCode)"
                    }
                }
                catch {
                }
                
                completion?(nil, NSError(domain: "API", code: httpCode, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
            }
            else {
                
                if data != nil && !data!.isEmpty {
                    
                    do {
                        
                        var returnData: [String : Any]?
                        
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                            
                            returnData = json
                        }
                        
                        completion?(returnData, nil)
                    }
                    catch let error2 {
                        
                        completion?(nil, error2)
                    }
                }
                else {
                    
                    completion?(nil, nil)
                }
            }
        })
        
        dataTask.resume()
    }
    
    private func get(from url: URL!, completion: SendCompletionBlockType?) {
        
        DispatchQueue.global(qos: .background).async {
            
            var request = URLRequest(url: url)
            request.configure(for: .get)
            
            DispatchQueue.main.async {
                
                self.send(request: request, completion: completion)
            }
        }
    }
    
    func query(location: CLLocationCoordinate2D, completion: ((_ weather: WeatherQueryItem?, _ error: Error?) -> ())?) {
        
        let queryItems = [
            URLQueryItem(name: Configuration.appid, value: Configuration.apiKey),
            URLQueryItem(name: Configuration.lat, value: "\(location.latitude)"),
            URLQueryItem(name: Configuration.lon, value: "\(location.longitude)")
        ]
        
        var urlComponents = URLComponents(url: Configuration.baseURL.appendingPathComponent(Configuration.weather), resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = queryItems
        
        let url = urlComponents.url!
        
        get(from: url) { (result, error) in
         
            if let _result = result {
                
                let weather = WeatherQueryItem(json: _result)
                
                DispatchQueue.main.async {
                    completion?(weather, nil)
                }
            }
            else {
                
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            }
        }
    }
    
}
