import 'package:dartz/dartz.dart';
import 'package:the_boring_app_flutter_demo_1/core/errors/failures.dart';
import 'package:the_boring_app_flutter_demo_1/features/random_activity/domain/entities/random_activity.dart';

abstract class RandomActivityRepository {
  Future<Either<Failure, RandomActivity?>>? getRandomActivity();
}
