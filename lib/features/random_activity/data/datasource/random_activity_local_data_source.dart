import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/data/models/random_activity_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class RandomActivityLocalDataSource {
  Future<void>? cacheRandomActivity(RandomActivityModel? activityToCache);
  Future<RandomActivityModel>? getLastRandomActivity();
}

const cachedRandomActivity = 'CACHED_RANDOM_ACTIVIY';

class RandomActivityLocalDataSourceImpl
    implements RandomActivityLocalDataSource {
  final SharedPreferences sharedPreferences;

  RandomActivityLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RandomActivityModel>? getLastRandomActivity() {
    final jsonString = sharedPreferences.getString(cachedRandomActivity);

    if (jsonString != null) {
      return Future.value(
          RandomActivityModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheRandomActivity(RandomActivityModel? activityToCache) {
    if (activityToCache != null) {
      return sharedPreferences.setString(
          cachedRandomActivity, json.encode(activityToCache.toJson()));
    } else {
      throw CacheException();
    }
  }
}
