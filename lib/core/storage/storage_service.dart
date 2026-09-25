import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final prefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be initialized in main');
});

class StorageService {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  StorageService(this._secureStorage, this._prefs);

  // Secure storage
  Future<void> saveApiKey(String apiKey) async {
    await _secureStorage.write(key: 'api_key', value: apiKey);
  }

  Future<String?> getApiKey() async {
    return await _secureStorage.read(key: 'api_key');
  }

  Future<void> deleteApiKey() async {
    await _secureStorage.delete(key: 'api_key');
  }

  // Regular storage
  Future<void> saveServerUrl(String url) async {
    await _prefs.setString('server_url', url);
  }

  String? getServerUrl() {
    return _prefs.getString('server_url');
  }

  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString('theme_mode', mode);
  }

  String getThemeMode() {
    return _prefs.getString('theme_mode') ?? 'system';
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    await _prefs.clear();
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final prefs = ref.watch(prefsProvider);
  return StorageService(secureStorage, prefs);
});
