import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:namer_app/generate_pdf.dart';

class DetailsPage extends StatelessWidget {
  final List idea;
  DetailsPage({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(idea[0])),
        body: Markdown(data: idea[1]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GeneratePdf().init(idea);
            ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Saved to Documents')));
          },
          child: Icon(Icons.file_upload_outlined),
        ));
  }
}
