import 'package:hive/hive.dart';

class Database {
  final _ideabox = Hive.box('ideas');
  List ideas = [];

  // If this is the first time opening the app
  void createInitialData() {
    ideas = [
      [
        "Biz Factory",
        """
BizFactory is a business idea generator built with Flutter. It leverages the power of AI to help users generate unique business models based on a keyword.

## Features

- **Idea Generation**: Users can input a keyword, and the app generates a comprehensive business model around that keyword using Gemini 1.5 flash.

- **Markdown Support**: The generated business model is returned in a readable markdown format, providing a clean and structured presentation of the idea.

- **Local Storage**: The app uses Hive for local storage, allowing users to save their generated ideas for later reference.

- **PDF Generation**: Users can convert the generated business model into a PDF document, which can be saved to the device's file system for easy sharing and offline access.

## Packages Used

- `english_words`: For generating English words.
- `provider`: For state management.
- `google_generative_ai`: For interacting with Gemini model.
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
"""
      ]
    ];
  }

  void save(String name, String idea) {
    ideas.add([name, idea]);
  }

  void delete(name) {
    ideas.removeAt(name);
  }

  void deleteLast() {
    ideas.removeLast();
  }

  void loadData() {
    ideas = _ideabox.get("IDEAS");
  }

  void saveData() {
    _ideabox.put("IDEAS", ideas);
  }
}
