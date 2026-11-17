# 🌦️ WeatherApp-Swift
An iOS Weather App built with SwiftUI that fetches real-time weather data from WeatherAPI and displays it across interactive screens with clean animations. Designed to provide users with a seamless and visually engaging experience.

---

### 🚀 Features
🌐 Search for any city worldwide and view live weather updates

📊 Multi-screen navigation: City input → Weather Details → Advanced Stats → City Image

📸 Fetches random city images using the Unsplash API for a dynamic visual experience

🎨 Smooth transitions and responsive UI built entirely in SwiftUI

🛠 API integration with error handling for invalid or unavailable cities

---
### 🛠 Tech Stack

| Tech | Description |
| --- | --- |
| Language | Swift 5 |
| Framework | SwiftUI |
| APIs | WeatherAPI, Unsplash |
| IDE | Xcode |

---
### 📸 Screenshots:
<img width="394" alt="Screenshot 2025-07-05 at 3 09 00 PM" src="https://github.com/user-attachments/assets/d93a7fc1-0e67-42a0-a8da-576e532ebbae" />
<img width="358" alt="Screenshot 2025-07-05 at 3 09 08 PM" src="https://github.com/user-attachments/assets/a6cef3e9-871d-4139-a02c-0ceb58d88143" />
<img width="341" alt="Screenshot 2025-07-05 at 3 09 15 PM" src="https://github.com/user-attachments/assets/d8a0f65e-48af-4f99-9857-93478c609792" />
<img width="374" alt="Screenshot 2025-07-05 at 3 09 29 PM" src="https://github.com/user-attachments/assets/e580c336-501c-4a7f-82a8-1e4392cbe3e5" />

---
### 📦 Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/Jabed1234/WeatherApp-Swift.git
   cd WeatherApp-Swift
   ```

2. Open the project in Xcode:

   ```bash
   open project2.xcodeproj
   ```

3. Add your API keys (see below), then run on the iOS Simulator or a connected device.

### 🔑 API Keys

The app needs two free keys. They are read from `project2/Info.plist` and are not stored in this repository.

1. Get a key from [WeatherAPI](https://www.weatherapi.com/) and an access key from [Unsplash Developers](https://unsplash.com/developers).
2. In `project2/Info.plist`, replace `YOUR_WEATHERAPI_KEY` and `YOUR_UNSPLASH_ACCESS_KEY` with your keys.
3. Tell git to ignore your local copy so the keys are never committed:

   ```bash
   git update-index --skip-worktree project2/Info.plist
   ```

---
### ✨ About Me
Jabed Miah – Aspiring iOS Developer | ML Enthusiast | Full Stack Developer
📫 Contact: jmiah5@fordham.edu

---
### 📑 License
This project is licensed under the MIT License.
