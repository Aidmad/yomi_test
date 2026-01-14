import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(String key, dynamic data) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(data));
}

Future<dynamic> loadData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final String? jsonString = prefs.getString(key);
  if (jsonString == null) return null;
  return jsonDecode(jsonString);
}

Future<void> clearData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<void> saveProgressData(List<Map<String, dynamic>> progressList) async {
  await saveData('progress_data', progressList);
}

Future<List<Map<String, dynamic>>?> loadProgressData() async {
  final data = await loadData('progress_data');
  if (data == null) return null;
  if (data is List) {
    return data.map((e) {
      if (e is Map) return Map<String, dynamic>.from(e);
      return <String, dynamic>{};
    }).toList();
  }
  return null;
}

Future<void> clearProgressData() async {
  await clearData('progress_data');
}

Future<void> saveSelectedKanaData(Map<String, dynamic> data) async {
  await saveData('selected_kana_data', data);
}

Future<Map<String, dynamic>?> loadSelectedKanaData() async {
  final data = await loadData('selected_kana_data');
  if (data == null) return null;
  if (data is Map) return Map<String, dynamic>.from(data);
  return null;
}

Future<void> clearSelectedKanaData() async {
  await clearData('selected_kana_data');
}
