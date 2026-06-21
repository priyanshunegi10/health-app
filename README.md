# Smart Health Advisory App 🏥

A comprehensive, full-stack Flutter mobile application designed to provide instant medical advisory, digital health record management, and real-time global health monitoring. 

Built not just as a basic CRUD app, but engineered to handle real-world constraints like API security, cloud storage costs, and asynchronous state management.

## 🚀 Key Features & Architecture

* **🧠 Heuristic AI Chatbot:** Integrated **Google Gemini 1.5 Flash** to provide instant, context-aware health advisory based on user symptoms (with strict medical liability disclaimers).
* **💾 Hybrid Record Vault (Cost-Optimized):** Bypassed expensive cloud storage by engineering a local-caching system. Medical PDFs are stored natively on the device using `path_provider`, while only the lightweight file-path strings and metadata are synced with **Firebase Firestore**.
* **🌍 Real-Time Outbreak Alerts:** Integrated **NewsAPI** REST endpoints to fetch and parse live global health news. Built with safe error handling to prevent UI crashes during offline states.
* **⚡ Native OS Bridging:** Implemented one-tap emergency calling (108) by bridging the Flutter UI directly with the native Android dialer intent using `url_launcher`.
* **📊 Bio-Metric Tracking:** Interactive calculators for BMI, BMR, and daily hydration goals using standard medical equations (e.g., Mifflin-St Jeor).
* **🔐 Secure Infrastructure:** Complete Firebase Authentication flow. API keys (Gemini & NewsAPI) are strictly encrypted and isolated using `flutter_dotenv`.

## 🛠️ Tech Stack

* **Frontend:** Flutter, Dart
* **Backend:** Firebase (Authentication, Cloud Firestore)
* **AI & APIs:** Google Generative AI SDK, http (NewsAPI)
* **State & Utilities:** Provider (State Management), FilePicker, OpenFile, DotEnv

## 📸 App Preview & Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/05620ccb-1ca6-4b57-8771-2f065f961d53" width="220" >
  <img src="https://github.com/user-attachments/assets/ba200dd6-cd23-4871-a2a7-0451123071f1" width="220" >
  <img src="https://github.com/user-attachments/assets/c73b4268-4024-44cf-884f-94dc6d57b913" width="220" >
  <img src="https://github.com/user-attachments/assets/1fce6699-c969-4d53-8e4d-31e909253496" width="220" >
</p>

---

## 🚀 Installation & Setup

**1. Clone the project:**

```bash
   git clone [https://github.com/priyanshunegi10/smart-health-advisory.git](https://github.com/priyanshunegi10/smart-health-advisory.git)
   cd smart-health-advisory
```
**2. Install dependencies:**

```Bash
flutter pub get
```

**3.Environment Setup (CRITICAL):**
Create a .env file in the root directory. Add your API keys:

```Code snippet
GEMINI_API_KEY=your_gemini_api_key_here
NEWS_API_KEY=your_news_api_key_here
```
**4. Firebase Configuration:**
Ensure you connect the app to your own Firebase project by adding the google-services.json file to android/app/.

**5. Run the App:**
```Bash
flutter run
```

**⚠️ Disclaimer**
This app is for educational and prototyping purposes. The AI advisory feature should not replace professional medical diagnosis.


