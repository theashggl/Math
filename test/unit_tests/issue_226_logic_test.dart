import 'package:flutter_apps/message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockListGeneration extends Mock implements ListGeneration {}

class MockDIVariables extends Mock implements DIVariables {}

void main() {
  group('functionalities.dart file test', () {
    late final MockDIVariables mockDIVariables;
    late final MockListGeneration mockListGeneration;
    late final ListGeneration listGeneration;
      mockDIVariables=MockDIVariables();
      mockListGeneration=MockListGeneration();


    when(() => mockDIVariables.streamsProcessorList).thenReturn([2, 2]);
    when(() => mockDIVariables.operation).thenReturn(OperationEnum.option1);

    listGeneration= ListGeneration.test(
        diVariables: mockDIVariables,);
    print(
        '${mockDIVariables.streamsProcessorList} list ${mockDIVariables.streamsProcessorList[0]} ${mockDIVariables.streamsProcessorList[1]}');//These print statements count 2 calls of the streamNumbers method's called()'s actual count

    test('arrayInitializer method test', () async {
      print('${mockDIVariables.operation} operation');//This print statements count 1 call of the streamNumbers method's called()'s actual count
     await listGeneration
          .arrayInitializer(diVariables: mockDIVariables);
      // print('${mockDIVariables.nums} operation 2');This print statements count 1 call of the streamNumbers method's called()'s actual count
      verify(() async=> await mockListGeneration.streamNumbers(99, const Duration(seconds: 1),
              (op1, op2) => op1 += op2, mockDIVariables.streamsProcessorList)).called(1);//It passes if no print statements are present and this is expected to be 7
      expect(listGeneration.answer, 80);
    });
  });
}
