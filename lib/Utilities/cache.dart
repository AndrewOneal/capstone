import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const String _cacheKey = 'wiki_cache';

  Future<Map<String, dynamic>> getCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString(_cacheKey);
    if (cachedData != null) {
      return json.decode(cachedData);
    }
    return {};
  }

  Future<void> updateCache(Map<String, dynamic> newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(newData);
    await prefs.setString(_cacheKey, jsonString);
  }

  Future<void> clearCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }

  Future<void> addToCache(String wikiID, int sectionNo) async {
    Map<String, dynamic> cache = await getCache();
    cache[wikiID] = {"sectionNo": sectionNo};
    await updateCache(cache);
  }

  Future<int> getSectionNo(String wikiID) async {
    Map<String, dynamic> cache = await getCache();
    if (cache.containsKey(wikiID)) {
      return cache[wikiID]['sectionNo'];
    }
    return 1;
  }

  Future<bool> isWikiIDInCache(String wikiID) async {
    Map<String, dynamic> cache = await getCache();
    return cache.containsKey(wikiID);
  }

  Future<void> updateExistingEntry(String wikiID, int newSectionNo) async {
    Map<String, dynamic> cache = await getCache();
    cache[wikiID]['sectionNo'] = newSectionNo;
    await updateCache(cache);
  }
}
