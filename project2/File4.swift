//
//  File4.swift
//  project2
//
//  Created by Jabed Miah on 5/12/24.
//

import Foundation
import SwiftUI

struct Page4: View {
    let cityName: String
    @State private var cityImage: UIImage?

    var body: some View {
        VStack {
            if let image = cityImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Loading image...")
            }
        }
        .onAppear {
            fetchCityImage(for: cityName)
        }
    }

    func fetchCityImage(for city: String) {
        let accessKey = "KBgI4O83E0YZ_Ql7T_Pzxq0Nc3ininaQdIj7R_Vl1ww"
        let imageURL = "https://api.unsplash.com/photos/random?query=\(city)&client_id=\(accessKey)"

        guard let url = URL(string: imageURL) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cityImage = image
                }
            } else {
                print("Error converting data to image")
            }
        }

        task.resume()
    }
}
