//  File.swift
//  project2
//
//  Created by Jabed Miah on 5/12/24.
//

import SwiftUI
import Foundation

struct Page2: View {
    let input: String
    @Binding var showError: Bool
    
    @State private var cityName: String = ""
    @State private var country: String = ""
    @State private var lastUpdated: String = ""
    @State private var tempC: Double = 0
    @State private var tempF: Double = 0
    @State private var feelsLikeC: Double = 0
    @State private var feelsLikeF: Double = 0
    @State private var condition: String = ""
    @State private var cloud: Int = 0
    @State private var isValidCity: Bool = true
    @State private var json: String = ""
    @State private var navigateToContentView: Bool = false // State to control NavigationLink to ContentView
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(country)
                    .font(.title)
                    .foregroundColor(.white)
                Text(cityName)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Last Updated:")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(lastUpdated)
                        .foregroundColor(.black)
                    
                    Text("Temperature:")
                        .font(.headline)
                        .foregroundColor(.black)
                    HStack {
                        Text("\(tempC, specifier: "%.1f")°C")
                            .foregroundColor(.black)
                        Text("/")
                            .foregroundColor(.black)
                        Text("\(tempF, specifier: "%.1f")°F")
                            .foregroundColor(.black)
                    }
                    
                    Text("Feels Like:")
                        .font(.headline)
                        .foregroundColor(.black)
                    HStack {
                        Text("\(feelsLikeC, specifier: "%.1f")°C")
                            .foregroundColor(.black)
                        Text("/")
                            .foregroundColor(.black)
                        Text("\(feelsLikeF, specifier: "%.1f")°F")
                            .foregroundColor(.black)
                    }
                    
                    Text("Condition:")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(condition)
                        .foregroundColor(.black)
                    
                    Text("Cloud Coverage:")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(cloud)%")
                        .foregroundColor(.black)
                }
                
                Spacer()
                if isValidCity{
                    NavigationLink(destination: Page3(cityName: input, weatherData: $json)) {
                        Text("Next Page")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                if !isValidCity {
                    Text("Invalid City")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    // Navigation link to go back
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $navigateToContentView,
                        label: {
                            Text("Go Back")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    )
                    //.hidden()
                }
            }
            .padding()
            .onAppear {
                fetchWeatherData(for: input)
            }
        }
        .onTapGesture {
            // You can add additional interactive elements here
        }
    }
    
    func fetchWeatherData(for city: String) {
        let apiKey = "9413702b5a44411b8e951912240205"
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(encodedCity)&aqi=no"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Unknown error")
                }
                showError = true // Show error alert
                isValidCity = false
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    cityName = decodedData.location.name
                    country = decodedData.location.country
                    lastUpdated = decodedData.current.last_updated
                    tempC = decodedData.current.temp_c
                    tempF = decodedData.current.temp_f
                    feelsLikeC = decodedData.current.feelslike_c
                    feelsLikeF = decodedData.current.feelslike_f
                    condition = decodedData.current.condition.text
                    cloud = decodedData.current.cloud
                    isValidCity = true
                    json = String(data: data, encoding: .utf8) ?? "" // Assign JSON data to state variable
                }
            } catch {
                print("Error decoding JSON: \(error)")
                isValidCity = false
            }
        }
        
        task.resume()
    }
}

struct WeatherData: Codable {
    let location: Location
    let current: Current
}

struct Location: Codable {
    let name: String
    let country: String
}

struct Current: Codable {
    let last_updated: String
    let temp_c: Double
    let temp_f: Double
    let feelslike_c: Double
    let feelslike_f: Double
    let condition: Condition
    let cloud: Int
}

struct Condition: Codable {
    let text: String
}
