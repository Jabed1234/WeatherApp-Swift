import SwiftUI
import Foundation

struct ContentView: View {
    @State private var input: String = ""
    @State private var isLinkActive: Bool = false
    @State private var shouldNavigate: Bool = false
    @State private var showError: Bool = false
    @State private var weatherData: [String] = []
    @State private var json: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.pink
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Weather App")
                        .font(.title)
                        .fontWeight(.bold)
                        //.foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    TextField("Enter any City in the world: ", text: $input)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                        .onSubmit {
                            fetchWeatherData(for: input)
                        }
                    
                    Spacer()
                    
                    if isLinkActive {
                        NavigationLink(
                            destination: Page2(input: input, showError: $showError),
                            isActive: $shouldNavigate,
                            label: {
                                Text("See Weather Data")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                        )
                    }
                    
                    Spacer()
                }
            }
            //.padding()
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text("Failed to fetch weather data or invalid city"), dismissButton: .default(Text("OK")))
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
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data:")
                print(jsonString)
                DispatchQueue.main.async {
                    json = jsonString
                    isLinkActive = true
                }
            } else {
                print("Unable to parse data")
            }
        }
        
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
