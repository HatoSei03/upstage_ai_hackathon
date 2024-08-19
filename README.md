# Juju - AI-Powered Tourism App for Jeju Island

## Project Overview

**Juju** is an AI-powered mobile application designed to enhance the tourism experience on Jeju Island. The app offers personalized itinerary planning, real-time language translation, cultural information, and a vibrant community platform. Juju aims to break down barriers such as language difficulties and unoptimized travel plans, providing a seamless and enriching experience for tourists visiting Jeju Island.

### Team Information
- **Team Name**: HKKT
- **Team Leader**: Thao Le
  - **Email**: lengocthao.dev@gmail.com
- **Team Members**:
  - Q.Huy Bui - Data Preparation - qhuy.bui.contact@gmail.com
  - M.Khoi Vo - Fullstack Developer - kvfromtg@gmail.com
  - T.Kiet Van - Prompt Engineer - vantuankiet.work@gmail.com

### Development Objectives
1. **Enhance the Tourist Experience**: Simplify itinerary planning, language translation, and cultural understanding.
2. **Personalization and Flexibility**: Provide highly personalized itineraries based on user preferences.
3. **Leverage AI for Optimization**: Use AI to optimize itinerary suggestions, language translation, and chatbot responses.
4. **Foster Cultural Exchange**: Promote cultural understanding through engaging content and community features.
5. **Drive Engagement and Interaction**: Encourage user-generated content and interaction through gamified elements.

## Installation

To run the Juju app locally, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/HatoSei03/upstage_ai_hackathon.git```
2. **Navigate to the project directory:**
```
cd Stour
```
3. **Install dependencies:**
```
flutter pub get
```
4. **Run the app:**
```
flutter run
```

Note: Ensure you have Flutter and Dart installed on your system. 


## Usage
Once the app is running, you can explore the following key features:

- Personalized Itinerary Planning: Input your travel dates, budget, and preferences to receive a tailored itinerary.
- PhotoTranslator: Use the PhotoTranslator to capture and translate Korean text into English.
- Cultural Information: Access detailed information about Jeju Island's culture, history, and attractions.
- Community Platform: Engage with other travelers, share experiences, and gain insights from the Juju community.

## Upstage API Integration
Juju utilizes the Upstage API extensively to deliver its core functionalities. Below are the key areas where Upstage API was integrated:

- Chat API:

  - Chatbot: Provides answers to general questions about Jeju Island.
  - Itinerary Generation: Generates optimized travel itineraries based on user input.
  - OCR Text Restructuring: Enhances the readability of text extracted using OCR.
- OCR Document API:
  - PhotoTranslator: Extracts Korean text from images captured by users.
- Translation API:
  - PhotoTranslator: Translates the extracted Korean text into English, making it accessible to a wider audience.

## Technology Stack
- Programming Language: Dart
- Framework: Flutter
- Backend: Firebase
- AI Integration: Upstage API (Chat, OCR, Translation)
- Platforms: Android, iOS
