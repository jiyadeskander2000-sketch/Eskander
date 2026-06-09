# 🔒 Ghost Lock AI

**خزنة رقمية سرية** تعمل كتطبيق عادي (آلة حاسبة / ملاحظات / طقس / مفكرة) وتحتوي على نظام دخول مخفي متعدد الطبقات.

---

## 🏗️ هيكل المشروع (Clean Architecture)

```
lib/
├── core/
│   ├── constants/      app_constants.dart
│   ├── theme/          app_theme.dart
│   └── utils/
│       ├── auth_service.dart          ← المصادقة (صوت، نقر، نمط، سحب)
│       ├── encryption_service.dart    ← AES-256 تشفير
│       ├── ghost_ai.dart              ← الذكاء الاصطناعي
│       └── screenshot_protection.dart ← منع لقطة الشاشة
│
├── data/
│   ├── datasources/    vault_database.dart   ← SQLite
│   ├── models/         (DTOs)
│   └── repositories/   (implementations)
│
├── domain/
│   ├── entities/       vault_entities.dart
│   ├── repositories/   (interfaces)
│   └── usecases/       (business logic)
│
├── presentation/
│   ├── bloc/           app_bloc.dart
│   └── pages/
│       ├── onboarding_screen.dart      ← إعداد أولي
│       ├── disguise_screen.dart        ← التمويه (حاسبة/ملاحظات/طقس/مفكرة)
│       ├── secret_entry_screen.dart    ← الدخول السري
│       ├── vault_home_screen.dart      ← لوحة التحكم
│       ├── vault_section_screen.dart   ← صور / ملفات
│       ├── support_screens.dart        ← ملاحظات + سجل + إعدادات
│       ├── ai_security_screen.dart     ← لوحة AI
│       └── backup_screen.dart          ← نسخ احتياطي
│
└── main.dart
```

---

## 🚀 إعداد المشروع

### 1. المتطلبات
- Flutter 3.19+
- Dart 3.0+
- Android Studio / VS Code
- JDK 17

### 2. تثبيت الحزم
```bash
flutter pub get
```

### 3. إنشاء ملفات Hive المولّدة
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. إعداد Firebase (اختياري للنسخ السحابي)
1. أنشئ مشروعاً في [Firebase Console](https://console.firebase.google.com)
2. فعّل Authentication (Anonymous أو Email)
3. فعّل Cloud Storage
4. حمّل `google-services.json` إلى `android/app/`

### 5. تشغيل التطبيق
```bash
flutter run --release
```

---

## 📱 خريطة الشاشات

| الشاشة | الوصف |
|--------|-------|
| `OnboardingScreen` | إعداد التمويه + طريقة الدخول + كلمات السر |
| `DisguiseScreen` | الواجهة المزيفة (حاسبة / ملاحظات / طقس / مفكرة) |
| `SecretEntryScreen` | واجهة المصادقة السرية |
| `VaultHomeScreen` | لوحة التحكم الرئيسية |
| `VaultSectionScreen` | عرض الصور / الفيديوهات / الملفات |
| `SecureNotesScreen` | الملاحظات المشفرة |
| `AttemptsLogScreen` | سجل محاولات الدخول |
| `SettingsScreen` | إعدادات التطبيق والأمان |
| `AiSecurityScreen` | لوحة الذكاء الاصطناعي والتوصيات |
| `BackupScreen` | النسخ الاحتياطي والاستعادة |

---

## 🔐 طرق الدخول السري

| الطريقة | الآلية |
|---------|--------|
| **الصوت** | انطق كلمة السر → بصمة نصية عبر STT |
| **تسلسل النقر** | انقر على مناطق محددة بترتيب سري |
| **الحاسبة** | اضغط `.` خمس مرات ثم `=` |
| **الملاحظات** | انقر على العنوان 7 مرات متتالية |
| **النمط** | ارسم نمطاً غير مرئي على الشاشة |
| **السحب** | سلسلة من حركات محددة |

---

## 🔑 نظام كلمات السر المتعددة

```
كلمة "محمد"   → يفتح الخزنة الرئيسية
كلمة "أحمد"   → يفتح وضع المطور
كلمة "علي"    → يفتح الخزنة الوهمية (عند الإكراه)
```

---

## 🛡️ طبقات الأمان

1. **AES-256-CBC** — تشفير كل ملف وملاحظة
2. **FlutterSecureStorage** — تخزين المفاتيح في Android Keystore
3. **FLAG_SECURE** — منع لقطة الشاشة داخل الخزنة
4. **قفل تلقائي** — بعد 5 محاولات فاشلة
5. **التقاط صورة المتطفل** — عند كل محاولة فاشلة
6. **تحليل AI** — اكتشاف الأنماط المشبوهة

---

## 📦 النشر على Google Play

```bash
# توقيع APK
flutter build appbundle --release

# ملف الإخراج:
# build/app/outputs/bundle/release/app-release.aab
```

**تذكر:**
- غيّر `applicationId` في `build.gradle`
- أنشئ `keystore.jks` وعدّل `key.properties`
- أضف `INTERNET` permission فقط إذا فعّلت Firebase

---

## ⚠️ ملاحظات مهمة

- لا تنسَ كلمة السر الرئيسية — **لا يوجد استرداد**
- نسخ احتياطية منتظمة ضرورية
- لا تشارك ملف `.glb` مع أحد

---

*Ghost Lock AI — حماية خصوصيتك بذكاء*
