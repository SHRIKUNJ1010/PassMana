import 'package:file_picker/file_picker.dart';

class FileUtility {
  static Future<String?> pickFileFromStorage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }
}
