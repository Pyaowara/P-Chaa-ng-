# 🍱 P'Chaa-ng Food Ordering System

A cross-platform food ordering and queue management system between customers and restaurant staff.

## � Prerequisites

Before starting, ensure your system has the following installed:

1. **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (For compiling the frontend app)
2. **[Dart SDK](https://dart.dev/get-dart)** (Usually bundled with Flutter, required for the backend)
3. **[Docker Desktop](https://www.docker.com/products/docker-desktop/)** (Used to automatically containerize the PostgreSQL database and Redis)
4. **Serverpod CLI** (Required to generate schema models and endpoints)
   ```bash
   dart pub global activate serverpod_cli 3.1.1
   ```

---

## 🔐 Environment Setup

Before launching the project, you must set up your local configuration and API keys.

### 1. Backend Passwords (`pchaa_server/config/passwords.yaml`)
Serverpod relies on a `passwords.yaml` file for database, Redis, S3, and Firebase credentials. This file is ignored by Git. 

Create a file at `pchaa_server/config/passwords.yaml` and reference this template:

```yaml
shared:
  googleClientSecret: '{"web":{"client_id":"YOUR_GOOGLE_CLIENT_ID","project_id":"YOUR_PROJECT_ID","auth_uri":"...","token_uri":"...","client_secret":"YOUR_SECRET"}}'
  
development:
  database: "YOUR_POSTGRES_PASSWORD"
  redis: "YOUR_REDIS_PASSWORD"
  minio_access_key: "YOUR_MINIO_ACCESS_KEY"
  minio_secret_key: "YOUR_MINIO_SECRET_KEY"
  firebase_project_id: "YOUR_FIREBASE_PROJECT_ID"
  firebase_client_email: "YOUR_FIREBASE_CLIENT_EMAIL"
  firebase_private_key: "YOUR_FIREBASE_PRIVATE_KEY"
```
*(Make sure to match the `database` and `redis` passwords to those used in your local Serverpod setup or Docker).*

### 2. Frontend Environment (`pchaa_flutter/.env`)
The Flutter app requires a `.env` file at the root of `pchaa_flutter`. This is ignored by Git to protect API keys.

Create a `.env` file in the `pchaa_flutter/` directory:

```env
# Google & Server Connections
GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com
SERVER_URL=http://localhost:8080/    # Or http://10.0.2.2:8080/ for Android Emulators

# Firebase Push Notifications
FIREBASE_API_KEY=YOUR_FIREBASE_API_KEY
FIREBASE_APP_ID=YOUR_FIREBASE_APP_ID
FIREBASE_MESSAGING_SENDER_ID=YOUR_FIREBASE_MESSAGING_SENDER_ID
FIREBASE_PROJECT_ID=YOUR_FIREBASE_PROJECT_ID
FIREBASE_STORAGE_BUCKET=YOUR_FIREBASE_STORAGE_BUCKET
```

---

## 🚀 Installation & Setup

### Option 1: Quick Start (Recommended)
You can build and start the entire stack (Database, Backend, and Frontend) automatically using the provided scripts.

**For Windows (PowerShell):**
```powershell
./start.ps1
```

**For macOS/Linux (Bash):**
```bash
chmod +x start.sh
./start.sh
```
*Note: This script will fetch all dependencies, generate Serverpod models, spin up Docker, apply DB migrations, and launch both the server and Flutter app in separate terminals.*

---

### Option 2: Manual Installation

If you prefer to start the services manually, follow these steps:

#### 1. Fetch Dependencies
Install packages for all three layers:
```bash
cd pchaa_client && dart pub get
cd ../pchaa_server && dart pub get
cd ../pchaa_flutter && flutter pub get
```

#### 2. Generate Serverpod Models
Generate the schema and client files from the backend:
```bash
cd pchaa_server
serverpod generate
```

#### 3. Start the Database (Docker)
Start PostgreSQL and Redis via Docker Compose:
```bash
# Still inside pchaa_server
docker compose up -d
```

#### 4. Run database migrations & Start Backend
Apply the database schemas and start the Dart server:
```bash
dart bin/main.dart --apply-migrations
```

#### 5. Start the Application
Open a **new terminal**, navigate to the Flutter project, and run:
```bash
cd pchaa_flutter
flutter run
```

## 📱 Project Overview

Solves the complexity of variable food customizations and daily queue management. It provides two distinct experiences:

- **Customer Side:** Real-time ordering, picking specific ingredient add-ons, scheduled pickups, and live queue tracking with Firebase Push Notifications.
- **Owner Side:** Dynamic menu management, live order fulfillment, role-based store settings (Open/Close), and ingredient availability toggling.

## 🛠 Tech Stack

- **Frontend:** Flutter (Mobile)
  - `google_sign_in` (OAuth 2.0 Identity)
  - `firebase_messaging` (FCM Push Notifications)
  - `ChangeNotifier` (Reactive State Management)
- **Backend:** Serverpod (Dart RPC Server)
- **Database:** PostgreSQL (Relational data + JSONB for flexible menu customizations)
- **Storage:** MinIO / AWS S3 (Self-hosted image buckets)

## 🏗 System Architecture

The app logic centers around a flexible JSON-based customization engine and an automated daily resetting queue, communicating via secure RPC endpoints.

### Key Modules:

- **Customization Engine:** Handles complex "Pick-one" or "Pick-many" add-ons for menu items, checking against live ingredient stock before cart checkout.
- **Hybrid Queue System:** Manages two distinct tracks—**I** (Immediate) and **S** (Scheduled). A scheduled backend `FutureCall` automatically resets the queue counters at exactly GMT+7 Midnight.
- **Global Operations:** Real-time shop status control (Open/Close) and operational hours synced to customers.
- **Notification Engine:** Direct backend integration with FCM to fire OS-level alerts when a customer's order status transitions (e.g., "Food is ready").

## 📊 Database Design

The system relies on a **PostgreSQL** schema optimized for data integrity and snapshotting:

1. **`store_settings`**: Global store hours and manual override toggles.
2. **`menu_items` & `ingredients`**: Base products linked to global ingredients with flexible JSONB customization schemas.
3. **`carts` & `orders`**: Dynamic pricing and state management. Records snapshot the exact price and variant chosen to prevent historical breakage.
4. **`daily_queue_counters`**: Automated daily reset logic for queue numbering.
5. **`fcm_token` & `user`**: Maps server-side Google identities and device push keys for persistent authentication.

---

## Project Prototype

![home](./images/home.png)
![menu](./images/menu.png)

## Sprint 1 Result

![s1_non_login](./images/s1_non_login.png)
![s1_que](./images/s1_que.png)
![s1_menu](./images/s1_menu.png)

## 📊 Developed by:

**66070092** | **66070148** | **66070245**
