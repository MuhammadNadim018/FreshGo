# FreshGo Flutter App

FreshGo is a sample food-delivery Flutter application built from a Figma design, demonstrating practical UI techniques, SVG integration, and smooth navigation.

## Features

- Responsive layouts throughout (header, search bar, banner, categories, discount cards)  
- SVG asset support and overflow positioning  
- Custom widgets: header, search, banner, category chips, discount cards, bottom navigation  
- Deep linking to detail pages with animated transitions  
- Clean theming with `AppColors` and `Typography`  

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.6.0  
- Dart ≥ 2.19.0  
- Android Studio or Xcode for simulators  
- VS Code or IntelliJ IDEA  

### Installation

1. Clone the repository  
   ```bash
   git clone https://github.com/yourusername/freshgo.git
   cd freshgo
   ```

2. Install dependencies  
   ```bash
   flutter pub get
   ```

3. Run on simulator or device  
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   └── typography.dart
├── features/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       ├── category_chip.dart
│   │       ├── discount_card.dart
│   │       └── bottom_nav.dart
│   └── detail/
│       └── detail_screen.dart
├── models/
│   ├── category.dart
│   └── place.dart
└── main.dart
```

## Usage & Navigation

- **Home Screen**  
  - Header with current location dropdown and notifications  
  - Search bar to filter menu or restaurants  
  - Banner with promotional message and “Order now” button  
  - Top Categories: tap a chip to filter by category (future enhancement)  
  - Top Discount: horizontally scroll discount cards  

- **Detail Screen**  
  - Tap “Order now” in the banner or any discount card to navigate  
  - Displays detailed information about the selected place  

### Routing

Navigation is handled via Flutter’s standard `Navigator`:

```dart
// From HomeScreen to DetailScreen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => DetailScreen(place: selectedPlace),
  ),
);
```

## Theming

- **Colors** in `core/theme/app_colors.dart`  
- **Typography** in `core/theme/typography.dart`  

Adjust theme values to match your brand or design system.

## SVG Asset Support

Ensure you have the `flutter_svg` package:

```yaml
dependencies:
  flutter_svg: ^2.0.0
```

Import and use SVGs:

```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset('assets/icons/map_pin.svg');
```

## Contributions

1. Fork the repository  
2. Create a feature branch (`git checkout -b feature-name`)  
3. Commit your changes (`git commit -m "Add feature"`)  
4. Push to the branch (`git push origin feature-name`)  
5. Open a pull request  

## License

This project is licensed under the MIT License.

Sources
