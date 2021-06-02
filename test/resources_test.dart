import 'package:flutter_test/flutter_test.dart';
import 'package:karee/navigation.dart';

void main() {
  setUp(() {});

  group('Router test -> ', () {
    test('Souscription route', () async {
      Route.on('/test/function/sync/add', (a) => a * 30);
      Route.on('/test/function/async/add', (a) async => Future.delayed(Duration(seconds: 3), () => a / 2));
      var a = 30, b = 50;
      // Future<int> result = KareeRouter.goto('/test/function/sync/add', parameter: [a, b]);
      expect(KareeRouter.goto('/test/function/sync/add', parameter: a), 900);
      expect(await KareeRouter.goto('/test/function/async/add', parameter: b), 25);
    });
  });
}
