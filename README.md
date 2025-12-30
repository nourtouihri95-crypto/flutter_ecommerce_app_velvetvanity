# Velvet Vanity 🛍️  
Flutter E-commerce App with PHP Backend

## 📌 Project Overview
Velvet Vanity is a cross-platform e-commerce application developed with Flutter (Dart) for the frontend and PHP + PostgreSQL for the backend.  
The application allows users to browse beauty products, manage a cart, add favorites, complete a checkout process, and interact with a simulated store locator.

This project was developed as part of an academic assignment to demonstrate mobile development concepts, UI navigation, state management, backend integration, and local data persistence.

---

## 📁 Project Structure

velvet_vanity/
│
├── backend/                # PHP backend (API + database connection)
│   ├── login.php
│   ├── register.php
│   ├── test.php
│   └── database.sql
│
├── flutter_app/            # Flutter application
│   ├── lib/
│   │   ├── main.dart
│   │   ├── main_navigation.dart
│   │   ├── products_page.dart
│   │   ├── product_details_page.dart
│   │   ├── cart_page.dart
│   │   ├── cart_provider.dart
│   │   ├── favorites_page.dart
│   │   ├── favorites_provider.dart
│   │   ├── checkout_page.dart
│   │   ├── promo_timer.dart
│   │   ├── stores_page.dart
│   │   ├── profile_page.dart
│   │   ├── product.dart
│   │   └── brand_logo.dart
│   ├── assets/
│   │   └── images/
│   └── pubspec.yaml
│
└── README.md

---

## 🚀 Features Implemented

### 🔐 Authentication
- Login & registration with PHP backend
- User roles supported (user / admin)
- Admin badge displayed in profile page

### 🛍️ Products
- Product grid with images, name, price, category
- Category filtering
- Product details page with animations

### ❤️ Favorites
- Add/remove favorites
- Persistent storage using SharedPreferences

### 🛒 Cart
- Add/remove products
- Quantity management
- Persistent cart (saved locally)

### 💳 Checkout
- Multi-step checkout process
- Progress bar
- Promo timer (countdown)
- Order confirmation

### 🧭 Navigation
- Bottom navigation bar
- Smooth page transitions (slide & fade animations)

### 📍 Stores (Bonus)
- Fake nearby store locations
- Intent actions:
  - Call store
  - Open Google Maps
  - Open website

---

## 🧠 Technical Choices
- Flutter & Dart for cross-platform UI
- Provider for state management
- SharedPreferences for local persistence
- PHP + PostgreSQL for backend authentication
- REST API communication via HTTP

---

## ⚙️ How to Run the Project

### 1️⃣ Backend (PHP)
Requirements:
- PHP 8+
- PostgreSQL
- Local server (XAMPP / WAMP / Laragon)

Run:
cd backend
php -S localhost:8000

---

### 2️⃣ Flutter App
Requirements:
- Flutter SDK
- Visual Studio Build Tools (Windows)
- Developer Mode enabled on Windows

Run:
cd flutter_app
flutter pub get
flutter run -d windows

---

## ⚠️ Technical Issues Encountered
During development, Android Studio emulator could not be used due to system limitations.  
As a workaround:
- The project was run on Windows desktop
- Visual Studio Build Tools were installed
- Flutter Desktop was used successfully

This allowed full development and testing of the application.

---

## 📚 Learning Outcomes
- Flutter UI & navigation
- State management with Provider
- Backend integration with PHP
- Local data persistence
- Git & GitHub project structuring
- Debugging platform-specific issues

---

## 👨‍🎓 Author
Your Name  
Academic Project – Flutter & Mobile Development
