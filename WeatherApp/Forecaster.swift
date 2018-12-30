//
//  Forecaster.swift
//  WeatherApp
//
//  Created by 舟木正憲 on 2018/12/30.
//  Copyright © 2018 masanori. All rights reserved.
//

import UIKit

class Forecaster: NSObject {

    static func forecast(cityName: String, completion: @escaping (ForecastResult) -> Void) {
        let appID = "APIKEY"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=" + cityName + "&APPID=" + appID
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let jsonData = data else {
                print("Josn data error")
                return
            }

            do {
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                completion(result)
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }

}

struct ForecastResult: Codable {
    var list:[Forcecast]
}

struct Forcecast: Codable {
    var dt_txt: String
    var main: Main
    var weather:[Weather]

    struct Main: Codable {
        var temp: Double
    }

    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
    }

    func getFormattedTemp() -> String {
        return String(format: "%.1f ℃", main.temp)
    }

    func getDescription() -> String {
        return weather.count > 0 ? weather[0].description : ""
    }

    func getIconText() -> String {
        if weather.count == 0 {
            return ""
        }
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }

    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
    }
}
