import 'package:flutter_apps/messages.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDIVariables extends Mock implements DIVariables {}

class TestListGeneration extends ListGeneration {
  TestListGeneration.test({required DIVariables diVariables})
      : super.test(diVariables: diVariables);

  @override
  int testableRandomInt(num maxNumber) => 10;
}

void main() {
  group('functionalities.dart file test', () {
    late MockDIVariables mockDIVariables;
    late TestListGeneration listGeneration;

    setUp(() {
      mockDIVariables = MockDIVariables();
      when(() => mockDIVariables.streamsProcessorList).thenReturn([2, 2]);
      when(() => mockDIVariables.operation).thenReturn(OperationEnum.option1);
      listGeneration = TestListGeneration.test(diVariables: mockDIVariables);
    });

    test('arrayInitializer method test', () async {
      await listGeneration.arrayInitializer(diVariables: mockDIVariables);
      expect(listGeneration.answer, 20); // 2 iterations, each adds fixed 10
    });
  });
}
