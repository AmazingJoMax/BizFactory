# Biz Factory

Biz Factory is a business idea generator built with Flutter. It leverages the power of AI, specifically the Gemini 1.5 flash model, to help users generate unique business models based on a keyword.

## Features

- **Idea Generation**: Users can input or generate a random keyword, and the app generates a comprehensive business model around that keyword.

- **Markdown Support**: The generated business model is returned in a readable markdown format, providing a clean and structured presentation of the idea.

- **Local Storage**: The app uses Hive for local storage, allowing users to save their generated ideas for later reference.

- **PDF Generation**: Users can convert the generated business model into a PDF document, which can be saved to the device's file system for easy sharing and offline access.

## Packages Used

- `english_words`: For generating English words.
- `provider`: For state management.
- `google_generative_ai`: For interacting with the Gemini model.
- `flutter_markdown`: For rendering markdown.
- `toastification`: For displaying notifications.
- `flutter_to_pdf` and `flutter_native_html_to_pdf`: For generating PDFs.
- `path_provider`: For accessing the file system.
- `markdown`: For parsing markdown.
- `open_filex`: For opening files.
- `hive` and `hive_flutter`: For local storage.
- `flutter_dotenv`: For managing environment variables.
- `external_path` and `permission_handler`: For managing file system permissions.
- `flutter_spinkit`: For displaying loading indicators.
- `flutter_native_splash`: For creating a native splash screen.

## Getting Started

To get started with Biz Factory, clone the repository and run `flutter run` in the root directory.

## Contributing

Contributions are welcome!
