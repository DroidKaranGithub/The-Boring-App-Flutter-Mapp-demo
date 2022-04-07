import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_boring_app_flutter_demo_1/core/connection/network_info.dart';

import 'package:the_boring_app_flutter_demo_1/core/errors/failures.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/data/datasource/random_activity_local_data_source.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/data/datasource/random_activity_remote_data_source.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/data/repositories/random_activity_repository_impl.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/domain/entities/random_activity.dart';

class RandomActivityProvider extends ChangeNotifier {
  RandomActivity? randomActivity;
  Failure? failure;
  RandomActivityProvider({
    this.randomActivity,
    this.failure,
  });
  eitherFailureOrActivity() async {
    RandomActivityRepositoryImpl repository = RandomActivityRepositoryImpl(
      remoteDataSource: RandomActivityRemoteDataSourceImpl(dio: Dio()),
      localDataSource: RandomActivityLocalDataSourceImpl(
          sharedPreferences: await SharedPreferences.getInstance()),
      networkInfo: NetworkInfoImpl(DataConnectionChecker()),
    );
    final failureOrActivity = await repository.getRandomActivity();
    failureOrActivity.fold((newFailure) {
      randomActivity = null;
      failure = newFailure;
      notifyListeners();
    }, (activity) {
      randomActivity = activity;
      failure = null;
      notifyListeners();
    });
  }
}
