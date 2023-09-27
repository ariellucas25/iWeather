//
//  weatherAPI.swift
//  iWeather
//
//  Created by Ariel Lucas  Luduvig on 19/09/23.
//

import Foundation
import Alamofire

func getWeather(cityName: String, apiKey: String, completion: @escaping (WeatherModel?) -> Void) {
    let baseUrl = "https://api.weatherapi.com/v1"
    let endpoint = "/current.json"
    let parameters: [String: Any] = [
        "key": apiKey,
        "q": cityName
    ]

    AF.request(baseUrl + endpoint, method: .get, parameters: parameters)
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                // Parse the JSON response and create a Weather instance
                if let json = value as? [String: Any],
                   let weatherData = parseWeatherData(json: json) {
                    // Call the completion handler with the Weather data
                    completion(weatherData)
                } else {
                    // If parsing fails, call the completion handler with nil
                    completion(nil)
                }
            case .failure(let error):
                print(error)
                // If the request fails, call the completion handler with nil
                completion(nil)
            }
        }
}




