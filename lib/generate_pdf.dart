import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';
import 'package:markdown/markdown.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';

class GeneratePdf {
  String? generatedPdfFilePath;

  final _flutterNativeHtmlToPdfPlugin = FlutterNativeHtmlToPdf();
  String? name;
  String? md;

  void init(List idea) {
    name = idea[0];
    md = idea[1];
    parseMarkdown(md!);
  }

  void parseMarkdown(String md) {
    var html = markdownToHtml(md);
    generatePdfDocument(html);
  }

  Future<void> generatePdfDocument(String html) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    String targetPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS);
    // final targetPath = appDocDir.path;
    var targetFileName = name;
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final generatedPdfFile =
          await _flutterNativeHtmlToPdfPlugin.convertHtmlToPdf(
        html: html,
        targetDirectory: targetPath,
        targetName: targetFileName!,
      );

      generatedPdfFilePath = generatedPdfFile?.path;
      // OpenFilex.open(generatedPdfFilePath!);
      print(generatedPdfFilePath);
    } else {
      await Permission.storage.request();
    }
  }
}
