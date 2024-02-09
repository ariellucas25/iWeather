//
//  weatherModel.swift
//  iWeather
//
//  Created by Ariel Lucas  Luduvig on 19/09/23.
//

import Foundation
import UIKit


struct WeatherModel {
    var city__: String
    var description: String
    var weatherIcon: UIImage?
    var temperature: String
    var isDayNum: Int?
}

func parseWeatherData(json: [String: Any]) -> WeatherModel? {
    guard let location = json["location"] as? [String: Any],
        let cityName = location["name"] as? String,
        let current = json["current"] as? [String: Any],
        let condition = current["condition"] as? [String: Any],
        let isDay = current["is_day"] as? Int,
        let description = condition["text"] as? String,
        let weatherIconURLString = condition["icon"] as? String,
        let temperatureCelsius = current["temp_c"] as? Double else {
            return nil
    }
    
    //Using URL(string:) initializer to create a UIImage from the icon URL.
    let weatherIconURL = URL(string: "https:" + weatherIconURLString)
    let weatherIconData = try? Data(contentsOf: weatherIconURL!)
    let weatherIcon = weatherIconData != nil ? UIImage(data: weatherIconData!) : nil
    
    
    //formating the temperature string
    let temperature = String(format: "%.1f°C", temperatureCelsius)

    //creating a weather Instance to return
    let weatherInstance = WeatherModel(city: cityName, description: description, weatherIcon: weatherIcon, temperature: temperature, isDayNum: isDay)

    print(weatherInstance)
    return weatherInstance
}
