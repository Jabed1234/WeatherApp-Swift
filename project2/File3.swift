//
//  File3.swift
//  project2
//
//  Created by Jabed Miah on 5/12/24.
//

import Foundation
import SwiftUI

struct Page3: View {
    let cityName: String
    @Binding var weatherData: String
    
    var body: some View {
        VStack {
            Text(cityName)
                .font(.title)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.blue))
                .foregroundColor(.white)
                .padding(.vertical)
            
            ScrollView {
                ForEach(parseWeatherData(), id: \.0) { (label, value) in
                    VStack {
                        Text(label)
                            .font(.headline)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green))
                            .foregroundColor(.white)
                        Text(value)
                            .font(.body)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.gray))
                            .foregroundColor(.white)
                            .padding(.bottom)
                    }
                }
            }
            .padding()
        }
    }
    
    func parseWeatherData() -> [(String, String)] {
        guard let data = weatherData.data(using: .utf8) else { return [] }
        
        do {
            let decodedData = try JSONDecoder().decode(MyWeatherData.self, from: data)
            return [
                ("Country", decodedData.location.country),
                ("Region", decodedData.location.region),
                ("Latitude", "\(decodedData.location.lat)"),
                ("Longitude", "\(decodedData.location.lon)"),
                ("Wind Speed (mph)", "\(decodedData.current.wind_mph)"),
                ("Wind Speed (kph)", "\(decodedData.current.wind_kph)"),
                ("Wind Direction", "\(decodedData.current.wind_dir)"),
                ("Gust (mph)", "\(decodedData.current.gust_mph)"),
                ("Gust (kph)", "\(decodedData.current.gust_kph)"),
                ("Humidity", "\(decodedData.current.humidity)%")
            ]
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
    }
}

struct MyWeatherData: Codable {
    let location: MyLocation
    let current: MyCurrent
}

struct MyLocation: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct MyCurrent: Codable {
    let wind_mph: Double
    let wind_kph: Double
    let wind_dir: String
    let gust_mph: Double
    let gust_kph: Double
    let humidity: Int
}

