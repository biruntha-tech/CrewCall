# CrewCall Flutter App - Navigation Flow

## 📱 Complete Navigation Structure

```
🏠 main.dart
├── Initial Route: "/welcome"
└── Routes:
    ├── "/welcome" → WelcomePage
    └── "/main" → MainNavigation

📍 WelcomePage (Entry Point)
├── 🔑 Login Button → AccountSignInPage
└── 📝 Sign Up Button → TalentSignupPage

🔐 AccountSignInPage
└── ✅ Successful Login → MainNavigation

📝 TalentSignupPage
├── 🔑 Login Link → AccountSignInPage
└── ✅ Create Account → TalentProfilePage

👤 TalentProfilePage (Profile Setup)
└── ✅ Complete Setup → MainNavigation

🏛️ MainNavigation (Bottom Navigation Hub)
├── 📍 Tab 0: HomePage
├── 📍 Tab 1: EventsPage (Reserved_events_page)
├── 📍 Tab 2: ProfilePage
└── ➕ FAB (Events Tab Only) → CreateEventPage

🏠 HomePage
├── 🔍 Search & Filter Talents
├── 👤 Tap Talent Card → TalentDetailPage (Full Screen)
└── 📋 Talent List Display

👤 TalentDetailPage (Full Screen)
├── 📸 Hero Image Header
├── ℹ️ About & Skills Section
├── 📅 Integrated Booking Form
└── ✅ Confirm Booking → Back to HomePage

📅 EventsPage (Reserved_events_page)
├── 🔍 Search & Filter Events
├── 📖 My Reservations Button → MyReservationsPage
├── 🕐 History Button → EventHistoryPage
├── 👥 Event Participants → Participants Dialog
├── 📋 Event Details → Event Details Dialog
└── ✅ Join Event → Reservation Confirmation

📖 MyReservationsPage
└── 📋 Display Reserved Events List

🕐 EventHistoryPage
└── 📋 Display Participated Events History

➕ CreateEventPage
├── 📸 Image Picker
├── 📅 Date/Time Selectors
├── 👥 Participant Management
└── ✅ Create Event → Back to EventsPage

👤 ProfilePage
├── 📸 Photo Upload (Image Picker)
├── 📍 Location (GPS + Manual)
├── 🔄 Switch Account → Dialog
│   ├── ❌ Cancel
│   ├── 📝 Create Account → TalentSignupPage
│   └── 🔑 Login Different → WelcomePage
├── 🚪 Log Out → Clear Data
└── 💳 Payment Settings

📝 BookingFormPage (Standalone - if needed)
├── 📅 Date/Time Selection
├── 💰 Compensation Options
├── 📍 Location Input
└── ✅ Confirm Booking → Success Message
```

## 🔄 Navigation Types Used

### 1. **Route-based Navigation**
- `initialRoute: "/welcome"`
- Named routes for main app flow

### 2. **Push Navigation**
- `Navigator.push()` for forward navigation
- `MaterialPageRoute` for page transitions

### 3. **Replace Navigation**
- `Navigator.pushReplacement()` for signup → profile setup
- `Navigator.pushAndRemoveUntil()` for switch account

### 4. **Bottom Navigation**
- `BottomNavigationBar` with `IndexedStack`
- Maintains state across tabs

### 5. **Modal Navigation**
- `showDialog()` for popups and confirmations
- `showDatePicker()` for date selection

## 🎯 Key Navigation Features

### **Authentication Flow**
```
WelcomePage → SignIn/SignUp → TalentProfile → MainNavigation
```

### **Main App Flow**
```
MainNavigation (Tabs: Home | Events | Profile)
├── Home: Talent browsing → Full-screen talent details
├── Events: Event management → Reservations & History
└── Profile: User management → Account switching
```

### **Booking Flow**
```
HomePage → TalentDetailPage → Integrated Booking Form → Confirmation
```

### **Account Management**
```
ProfilePage → Switch Account Dialog → WelcomePage/SignUpPage
```

## 📱 Navigation State Management

- **Bottom Navigation**: Uses `IndexedStack` to preserve state
- **User Data**: Global `UserData` class for persistence
- **Events**: Global `globalReservedEvents` list
- **Navigation Stack**: Proper cleanup with `pushAndRemoveUntil`

## 🎨 UI Consistency

- **App Theme**: Consistent `AppColors.primary` throughout
- **Border Design**: Black border containers on all pages
- **Navigation**: Unified app bar styling and navigation patterns