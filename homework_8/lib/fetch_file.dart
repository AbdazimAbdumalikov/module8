import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return rootBundle
      .loadString(assetsPath)
      .then((file) => file.toString())
      .catchError((error) => 'Файл не найден');
}

Stream<String> getData(String? assetsPath) async* {
  String str;
  if (assetsPath != null) {
    try {
      str = await rootBundle
          .loadString('assets/$assetsPath.txt')
          .then((value) => value.toString())
          .catchError((error) => 'Файл не найден');
      yield str;
    } catch (e) {
      print(e); // Здесь можно обработать исключение
    }
  } else {
    str = '';
    yield str;
  }
}