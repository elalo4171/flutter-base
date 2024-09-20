import 'package:my_app/app/app.dart';
import 'package:my_app/bootstrap.dart';
import 'package:my_app/flavors.dart';

void main() {
  bootstrap(() => const App(), Flavor.DEV);
}
