import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:qr_reader/injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);
