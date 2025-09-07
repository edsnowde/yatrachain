# yatrachain

# 🚖 YatraChain  
**Smart Trip Logger for a Smarter Kerala**  

YatraChain is a Flutter-based mobile app that automatically detects trips (bus/train/cab) using GPS and logs them for later viewing.  
It uses Google Maps API for location tracking and visualization, helping citizens track and manage their daily commutes seamlessly.

---

## 📸 Screenshots  

---

## 📱 Features  
✅ Beautiful gradient **Home Page**  
✅ **Bottom Navigation Bar** with 3 sections:  
- **Home** → App intro & tagline  
- **Trips** → View previously logged trips  
- **Map** → Real-time trip tracking with Google Maps  
✅ **Automatic Trip Detection** (start/stop based on movement)  
✅ Search bar to find any place  
✅ Local trip saving (to be upgraded with database)

---

## 🛠️ Tech Stack  
- **Flutter** (3.x) – Cross-platform app development  
- **Google Maps Flutter** – Map rendering  
- **Geolocator** – GPS & location services  
- **Material Design** – UI Components  

---

## 📂 Project Structure  
yatrachain/
│
├── lib/

│ ├── main.dart # Entry point

│ ├── main_screen.dart # Bottom navigation bar controller

  ├──pages
  
│         ├── home_page.dart # Gradient intro page

│         ├── trip_tracking_page.dart# Map + trip detection

│         └── trips_page.dart # List of previous trips

│

├── assets/

│ └── travel.png # App illustration
│


├── pubspec.yaml # Flutter dependencies

└── README.md # This file



A new Flutter project.

## Getting Started

the commands 

git clone <your-repo-url>
cd yatrachain
flutter pub get
//set up the emulater then run the below command
flutter run


or choose device manually:

flutter devices
flutter run -d <device-id>



4️⃣ Environment Variables (if using Google Maps API)

update AndroidManifest.xml with your Google Maps API Key:
yatrachain\android\app\src\main

<meta-data
  android:name="com.google.android.geo.API_KEY"
  android:value="enter your YOUR_API_KEY"/>


