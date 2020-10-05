import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:news_shot/injection.config.dart';

final GetIt getIt = GetIt.asNewInstance();

@injectableInit
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}
