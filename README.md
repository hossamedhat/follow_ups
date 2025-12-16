# Follow Ups – Flutter Follow-Up Management App

تطبيق **Follow Ups** هو مشروع Flutter لإدارة ومتابعة الـ Follow-Ups (المتابعات) بشكل احترافي، مع بحث فوري، فلترة، دعم للوضع الداكن، وواجهة متجاوبة تعمل بشكل ممتاز على الموبايل والـ Tablet.

---

## 🎯 فكرة المشروع

هدف التطبيق هو توفير شاشة واحدة لإدارة ومراجعة الـ Follow-Ups:

- **عرض قائمة بالـ Follow-Ups** في شكل كروت حديثة
- كل عنصر يعرض:
  - **ID** (مثل: `FU-1001`)
  - **Title / Subject** (عنوان المتابعة)
  - **Description** (نص عادي أو HTML يتم عرضه تلقائيًا)
  - **Type**: Call / Meeting / Visit مع أيقونة مميزة
  - **Status**: Completed / Scheduled / No Status مع **ألوان مميزة** لكل حالة
  - **Customer Name** (إن وجد)
- **بحث فوري** مع **Debounced Search** (لا يتم الفلترة مع كل حرف فورًا)
- **فلترة حسب الحالة** من خلال Bottom Sheet
- **Dark / Light Mode** مع حفظ آخر اختيار
- **Responsive UI** للموبايل والتابلت

---

## 🏗 Architecture المستخدم

المشروع مبني على **Clean Architecture** مع فصل واضح للطبقات:

### State Management
- **`flutter_bloc`** باستخدام **Cubit** (بدون Events معقدة)

### Dependency Injection
- **`get_it`** كـ Service Locator لتسجيل وإدارة الـ Services والـ Cubits

### Layers الرئيسية

#### 1. Models (`lib/models/`)
- `follow_up.dart`:
  - `FollowUpType` (call / meeting / visit)
  - `FollowUpStatus` (completed / scheduled / none)
  - كلاس `FollowUp` مع جميع البيانات

#### 2. Services (Data Layer) (`lib/services/`)
- `follow_up_service.dart`:
  - `FollowUpService` (abstract) – يمكن استبداله بأي API حقيقي
  - `MockFollowUpService` – بيانات Mocked للاختبار
- `theme_storage_service.dart`:
  - يستخدم `flutter_secure_storage` لحفظ واسترجاع `ThemeMode`

#### 3. Cubits (Business Logic) (`lib/cubit/`)
- **FollowUpCubit**:
  - `loadFollowUps()` – تحميل البيانات
  - `onSearchChanged(String query)` – بحث مع **Debounce (300ms)**
  - `changeStatusFilter()` – فلترة حسب الحالة
- **ThemeCubit**:
  - `toggleTheme()` – تبديل بين Light/Dark
  - حفظ الثيم في `flutter_secure_storage`

#### 4. Dependency Injection (`lib/core/di/`)
- `service_locator.dart`:
  - تسجيل Services و Cubits باستخدام `get_it`

#### 5. Views & Widgets
- `lib/views/follow_up_list_screen.dart` – الشاشة الرئيسية
- `lib/widgets/follow_up_card.dart` – كارت الـ Follow-Up
- `lib/widgets/empty_state.dart` – حالة عدم وجود بيانات
- `lib/widgets/filter_bottom_sheet.dart` – Bottom Sheet للفلترة

---

## 🚀 خطوات التشغيل

### المتطلبات
- Flutter SDK (3.x أو أعلى)
- تأكد من الإعداد:
```bash
flutter doctor
```

### 1. تنزيل الحزم
```bash
flutter pub get
```

### 2. تشغيل التطبيق
```bash
flutter run
```

### 3. ما الذي ستراه؟
- **الشاشة الرئيسية**: قائمة بالـ Follow-Ups في كروت
- **البحث**: اكتب في خانة البحث → الفلترة تحدث بعد 300ms (Debounced)
- **الفلتر**: اضغط زر الفلتر → اختر الحالة من Bottom Sheet
- **Dark Mode**: اضغط أيقونة الثيم في AppBar للتبديل
- **Responsive**: على التابلت → Grid بعمودين، على الموبايل → List

---

## 🌙 Dark Mode

التطبيق يدعم **Dark Mode** بشكل كامل:

### التفعيل
- زر في الـ **AppBar** (أيقونة الشمس/القمر) للتبديل بين Light/Dark
- التطبيق **يحفظ آخر اختيار** في `flutter_secure_storage`
- عند إعادة فتح التطبيق، يتم تطبيق الثيم المحفوظ تلقائيًا

### الألوان
- **Light Theme**: ألوان فاتحة مع Gradient أزرق فاتح
- **Dark Theme**: ألوان داكنة مع Gradient أزرق داكن/رمادي

### الكود
```dart
// ThemeCubit يدير الثيم
ThemeCubit(themeStorageService)
  ..toggleTheme() // تبديل فوري
  ..setTheme(ThemeMode.dark) // تعيين مباشر
```

---

## 🎨 ألوان الحالات (Status Colors)

كل حالة في الـ Follow-Up لها لون مميز:

### ✅ Completed (مكتمل)
- **اللون**: **أخضر** (`Colors.green.shade600`)
- **الاستخدام**: Badge + Dot indicator في الكارت

### 📅 Scheduled (مجدول)
- **اللون**: **أصفر/برتقالي** (`Colors.orange.shade600`)
- **الاستخدام**: Badge + Dot indicator في الكارت

### ⚪ No Status (بدون حالة)
- **اللون**: **رمادي** (`Theme.colorScheme.outline`)
- **الاستخدام**: Badge + Dot indicator في الكارت

### الكود
```dart
Color _statusColor(BuildContext context) {
  switch (followUp.status) {
    case FollowUpStatus.completed:
      return Colors.green.shade600;  // أخضر
    case FollowUpStatus.scheduled:
      return Colors.orange.shade600; // أصفر/برتقالي
    case FollowUpStatus.none:
      return Theme.of(context).colorScheme.outline; // رمادي
  }
}
```

---

## ⏳ Debounced Search

البحث في التطبيق يستخدم **Debounced Search** لتحسين الأداء:

### كيف يعمل؟
- عند كتابة حرف في خانة البحث، **لا يتم الفلترة فورًا**
- يتم **انتظار 300ms** بعد آخر حرف
- لو المستخدم كتب حرف جديد قبل انتهاء الـ 300ms، يتم **إلغاء الفلترة السابقة** وبدء انتظار جديد

### الفائدة
- **أداء أفضل**: لا يتم فلترة البيانات مع كل حرف
- **تجربة مستخدم أفضل**: لا توجد تأخيرات أو "lag" أثناء الكتابة
- **توفير موارد**: تقليل عدد العمليات غير الضرورية

### الكود
```dart
void onSearchChanged(String query) {
  _debounceTimer?.cancel(); // إلغاء الفلترة السابقة
  _debounceTimer = Timer(const Duration(milliseconds: 300), () {
    // بعد 300ms → تطبيق الفلترة
    emit(
      state.copyWith(
        searchQuery: query,
      ).withAppliedFilters(),
    );
  });
}
```

### الاستخدام
- اكتب في خانة البحث → انتظر جزء من الثانية → النتائج تظهر تلقائيًا
- البحث يعمل على:
  - **Title** (العنوان)
  - **Customer Name** (اسم العميل)

---

## 📦 Project Structure

```
lib/
├── core/
│   ├── di/
│   │   └── service_locator.dart      # get_it setup
│   └── theme/
│       ├── app_decorations.dart      # Shared decorations
│       └── theme_basic.dart          # Light/Dark themes
├── cubit/
│   ├── follow_up/
│   │   ├── follow_up_cubit.dart      # Business logic
│   │   └── follow_up_state.dart      # State management
│   └── theme/
│       └── theme_cubit.dart          # Theme management
├── models/
│   └── follow_up.dart                # Data models
├── services/
│   ├── follow_up_service.dart        # Data layer
│   └── theme_storage_service.dart    # Theme persistence
├── views/
│   └── follow_up_list_screen.dart    # Main screen
├── widgets/
│   ├── follow_up_card.dart           # Follow-up card
│   ├── empty_state.dart              # Empty state widget
│   └── filter_bottom_sheet.dart      # Filter bottom sheet
└── main.dart                         # App entry point
```

---

## 🛠 Tech Stack

- **Flutter** (3.x, null-safety)
- **State Management**: `flutter_bloc` (Cubit)
- **Dependency Injection**: `get_it`
- **Responsive Design**: `flutter_screenutil`
- **Theme Persistence**: `flutter_secure_storage`
- **HTML Rendering**: `flutter_html`
- **Icons**: `font_awesome_flutter`

---

## 📝 Features Summary

✅ عرض قائمة Follow-Ups في كروت حديثة  
✅ بحث فوري مع **Debounced Search (300ms)**  
✅ فلترة حسب الحالة (All / Completed / Scheduled / No Status)  
✅ **Dark / Light Mode** مع حفظ التفضيلات  
✅ **ألوان مميزة للحالات** (أخضر / أصفر / رمادي)  
✅ Responsive Design (Mobile & Tablet)  
✅ HTML rendering في الـ Description  
✅ Empty State handling  
✅ Clean Architecture مع Cubit + get_it  

---

## 🔗 Repository

[GitHub Repository](https://github.com/hossamedhat/Follow_Ups)

---

## 📄 License

This project is private and not licensed for public use.

---

**تم إنشاء المشروع باستخدام Flutter و Clean Architecture** 🚀

