# VidForce

A modern Flutter app for AI-powered image and video generation from templates.

## Features

- 🎬 **Template-Based Generation**: Browse curated AI templates
- ⚡ **Credit System**: Transparent pricing with credit packs
- 🎨 **Dark-First UI**: Beautiful, modern interface
- 📱 **Cross-Platform**: Works on iOS, Android, and Web
- 🚀 **Fast & Smooth**: Optimized performance with animations

## Architecture

- **State Management**: Riverpod
- **Navigation**: go_router
- **UI**: Material Design 3 with custom dark theme
- **Data**: Mock API service for development

## Project Structure

```
lib/
├── app/                 # App configuration (router, theme)
├── core/                # Shared utilities and widgets
│   ├── constants/       # Design tokens (colors, spacing, typography)
│   ├── theme/           # App theme configuration
│   └── widgets/         # Reusable UI components
├── data/                # Data layer
│   ├── api/             # API services and mock data
│   └── providers/       # Riverpod providers
├── domain/              # Business logic layer
│   └── entities/        # Domain models
└── features/            # Feature modules
    ├── onboarding/      # Onboarding screens
    ├── home/            # Home screen
    ├── template_detail/ # Template details
    ├── generate/        # Generation flow
    ├── my_creations/    # User's creations
    ├── account/         # Account settings
    └── credits/         # Credit packs
```

## Getting Started

### Prerequisites

- Flutter SDK 3.2.0 or higher
- Dart 3.0 or higher

### Installation

1. Clone the repository:
```bash
git clone https://github.com/muratcankuruoffical/vidforce.git
cd vidforce
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Design System

### Colors

- **Background**: #0D0F12
- **Surface**: #13161B
- **Card**: #181C22
- **Accent Lime**: #C5FF3B
- **Accent Blue**: #4DA3FF

### Typography

- **Font**: Inter (Google Fonts)
- **Sizes**: H1 (28px), H2 (22px), H3 (18px), Body (16px), Small (13px)

## Features Overview

### Onboarding

- 3-step intro carousel
- Smooth animations
- Skip option

### Home

- Featured templates carousel
- Trending templates grid
- Category exploration

### Template Detail

- Full template preview
- Aspect ratio options
- Credit cost display
- Requirements list

### Generate Flow

- 3-step wizard (Assets, Options, Summary)
- Progress indicator
- Cost preview

### My Creations

- Grid view of creations
- Status indicators (Processing, Done, Failed)
- Quick actions

### Account

- Credit balance display
- Purchase history
- Settings
- Help center

### Credit Packs

- 4 pack options
- Best value highlighting
- Instant purchase

## Technologies Used

- **flutter_riverpod**: State management
- **go_router**: Navigation
- **cached_network_image**: Image caching
- **flutter_animate**: Animations
- **shimmer**: Loading effects
- **google_fonts**: Typography
- **dio**: HTTP client

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

## Contact

Murat Can Kuru - [@muratcankuruoffical](https://github.com/muratcankuruoffical)

Project Link: [https://github.com/muratcankuruoffical/vidforce](https://github.com/muratcankuruoffical/vidforce)
