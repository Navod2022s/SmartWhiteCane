# SmartWhiteCane 🦯

An intelligent assistive device for the visually impaired using IoT technology, object detection, and haptic feedback.

## 🎯 Project Overview

SmartWhiteCane is an advanced white cane equipped with IoT sensors and AI-powered capabilities that helps visually impaired users navigate safely. The system combines:

- **Real-time object detection** via ESP32-CAM
- **Ultrasonic distance sensing** with haptic feedback (HC-SR04)
- **Audio feedback** through speaker output
- **Wireless connectivity** for remote monitoring and assistance

## 🛠️ Hardware Components

| Component | Specification | Purpose |
|-----------|---------------|---------|
| **Microcontroller** | ESP32-S3 | Main processing unit |
| **Camera Module** | ESP32-CAM | Object detection & tracking |
| **Distance Sensor** | HC-SR04 Ultrasonic | Obstacle detection |
| **Haptic Motors** (3x) | Vibration Motors | Directional feedback (left, right, bottom) |
| **Audio Output** | MAX98357A (I2S Speaker) | Text-to-speech & alerts |
| **Power** | Battery-powered | Portable operation |

## 📌 Pin Configuration

```
WIFI & NETWORK:
  - WiFi: Standard 802.11b/g/n (built-in ESP32)
  - UDP Communication Ports:
    - Camera: Port 4210
    - Audio: Port 4212

SENSOR PINS:
  - Ultrasonic Trigger: GPIO 16
  - Ultrasonic Echo: GPIO 5
  - Haptic Left: GPIO 6
  - Haptic Right: GPIO 7
  - Haptic Bottom: GPIO 15

CAMERA PINS:
  - RX: GPIO 8
  - TX: GPIO 9

AUDIO PINS (I2S Output):
  - BCLK: GPIO 10
  - LRC/WS: GPIO 11
  - DIN: GPIO 12
  - Sample Rate: 24000 Hz
```

## 🚀 Key Features

### 1. **Object Detection & Tracking**
- Receives TRACK confidence data from ESP32-CAM via UART
- Implements threshold-based filtering (0.85 confidence threshold)
- Requires 3 consecutive frames above threshold to trigger detection
- 3-second cooldown period to prevent false positives
- 
### 2. **Distance-Based Haptic Feedback**
- **SAFE ZONE** (150+ cm): No vibration
- **AWARE ZONE** (80-150 cm): Vibration every 1 second
- **WARNING ZONE** (40-80 cm): Vibration every 400ms
- **DANGER ZONE** (15-40 cm): Vibration every 150ms
- **IMPACT ZONE** (<15 cm): Continuous vibration (all motors)

### 3. **Real-time Audio Output**
- Receives audio streams via UDP
- Outputs to external speaker via I2S interface
- Supports Google TTS and other text-to-speech services
- Adjustable sample rates (16000-48000 Hz)

### 4. **Dual-Core Processing**
- **Core 0**: Audio reception and playback task
- **Core 1**: Main sensor processing, object detection, haptic control

## 📋 System Specifications

- **Sample Rate**: 24000 Hz (configurable)
- **Detection Threshold**: 0.85 confidence
- **Frame Requirement**: 3 consecutive frames
- **Detection Cooldown**: 3 seconds
- **Ultrasonic Range**: Up to 450cm
- **Haptic Pattern**: Dynamic frequency based on distance

## 🔧 Configuration

Edit the following constants in `test03.ino`:

```cpp
const char* ssid = "your_wifi_ssid";
const char* password = "your_wifi_password";
const char* targetIP = "your_target_device_ip";
const float THRESHOLD = 0.85;  // Detection confidence
const int REQUIRED_FRAMES = 3; // Frames to confirm detection
const unsigned long COOLDOWN_MS = 3000; // Cooldown period
#define SAMPLE_RATE 24000; // Audio sample rate
```

## 📁 Project Files

- **`test03.ino`** - Main firmware for ESP32-S3
- **`Smart_cane.zip`** - Complete project documentation and resources
- **`firmware`** - Additional firmware configurations

## 🔌 How It Works

1. **Initialization**
   - System boots and connects to WiFi
   - I2S speaker interface initializes
   - Audio reception task starts on Core 0

2. **Main Loop** (Core 1)
   - Reads ultrasonic distance every 60ms
   - Updates haptic patterns based on distance zone
   - Monitors UART for camera tracking data
   - Sends UDP trigger signals to mobile app/external device

3. **Object Detection**
   - Receives confidence scores from ESP32-CAM
   - Filters frames below threshold
   - Sends "track" command via UDP when detection confirmed
   - Enters cooldown to prevent rapid re-triggers

4. **Haptic Feedback**
   - Activates vibration motors based on distance
   - Provides tactile navigation assistance
   - All motors vibrate together for imminent collision warning

## 🌐 Network Communication

### UDP Connections
- **Camera Detection**: Sends "track" message to app on port 4210
- **Audio Stream**: Receives audio data on port 4212
- Both operate simultaneously without blocking

## 🎮 Operating Modes

| Zone | Distance | Haptic Pattern | Action |
|------|----------|----------------|--------|
| SAFE | 150+ cm | Off | Normal operation |
| AWARE | 80-150 cm | 1 second pulse | Caution |
| WARNING | 40-80 cm | 400ms pulse | Alert user |
| DANGER | 15-40 cm | 150ms pulse | Strong alert |
| IMPACT | <15 cm | Continuous | Critical warning |

## 📝 Serial Communication

- **Baud Rate**: 115200
- **Protocol**: UART with newline-delimited strings
- **Format**: `TRACK:confidence_value`
- **Example**: `TRACK:0.92`

## 🐛 Debugging

Serial monitor outputs include:
- System status messages
- Camera detection logs with confidence scores
- Frame filtering information
- Haptic state updates
- UDP communication confirmations

## 📦 Dependencies

- ESP32 Arduino Core
- WiFi Library
- WiFiUDP Library
- I2S Driver (ESP32)
- Arduino Serial Libraries

## 🚦 Getting Started

1. Clone or download this repository
2. Open `test03.ino` in Arduino IDE
3. Configure WiFi credentials and target IP
4. Select **ESP32-S3** board
5. Upload firmware to ESP32-S3
6. Monitor serial output to verify functionality

## ⚠️ Important Notes

- Ensure WiFi credentials are correct before deployment
- Adjust THRESHOLD and REQUIRED_FRAMES based on camera accuracy
- Test haptic patterns thoroughly before field use
- Monitor battery level during extended use
- Set appropriate SAMPLE_RATE for audio quality (24000 Hz is recommended)

## 🤝 Contributing

This is an assistive technology project aimed at improving accessibility. Contributions to enhance functionality and reliability are welcome!

## 📄 License

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

This project is licensed under the Apache License, Version 2.0. See the [LICENSE](LICENSE) file for details.

A NOTICE file with third-party attributions is included in this repository — see the [NOTICE](NOTICE) file for details.

## 👤 Authors

- Navod2022s (Project lead)
- Member Name 1 — @githubHandle1
- Member Name 2 — @githubHandle2
- Member Name 3 — @githubHandle3

---

*SmartWhiteCane - Empowering independence through technology* 🌟
