//
//  WeatherManager.swift
//  04_Clima
//
//  Created by Arturo Iván Chávez Gómez on 29/04/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d6446c819ca67b431d17532fd7afcbd8&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func searchWeather(city: String){
        let urlString = "\(weatherURL)&q=\(city)"
        makeRequest(urlString: urlString)
    }
    
    func searchDevice(lon: Double, lat: Double){
        let urlString = "\(weatherURL)&lon=\(lon)&lat=\(lat)"
        makeRequest(urlString: urlString)
    }
    
    func makeRequest(urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                if let secureData = data {
                    if let weatherObject = self.parseJSON(weatherData: secureData) {
                        //let weatherVC = ViewController()
                        //weatherVC.updateWeather(weatherobject: weatherObject)
                        self.delegate?.updateWeather(weather: weatherObject)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let city = decodedData.name
            let temp = decodedData.main.temp
            let feels_like = decodedData.main.feels_like
            let humidity = decodedData.main.humidity
            let lon = decodedData.coord.lon
            let lat = decodedData.coord.lat
            
            let weatherObject = WeatherModel(id: id, temp: temp, feels_like: feels_like,lon: lon, lat: lat, humidity: humidity, cityName: city)
            
            //weatherObject.getWeatherCondition(idWeather: id)
            
            print(weatherObject.weatherCondition)
            print(weatherObject.tempString)
            
            return weatherObject
            
        } catch {
            return nil
        }
    }
}
