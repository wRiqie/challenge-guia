import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_guia/app/business_logic/cubits/motels/motels_cubit.dart';
import 'package:challenge_guia/app/business_logic/cubits/motels/motels_state.dart';
import 'package:challenge_guia/app/data/models/default_response_model.dart';
import 'package:challenge_guia/app/data/models/error_model.dart';
import 'package:challenge_guia/app/data/models/motel_model.dart';
import 'package:challenge_guia/app/data/models/paginable_model.dart';
import 'package:challenge_guia/app/data/repositories/motels_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock do repositório
class MotelsRepositoryMock extends Mock implements MotelsRepository {}

void main() {
  late MotelsCubit motelsCubit;
  late MotelsRepositoryMock motelsRepository;

  setUp(() {
    motelsRepository = MotelsRepositoryMock();
    motelsCubit = MotelsCubit(motelsRepository);
  });

  tearDown(() {
    motelsCubit.close();
  });

  group('MotelsCubit', () {
    final mockMotels = PaginableModel(
      items: [
        MotelModel(
            name: 'Motel A',
            logoUrl: '',
            address: '',
            distance: 0,
            favoriteAmount: 0),
        MotelModel(
            name: 'Motel B',
            logoUrl: '',
            address: '',
            distance: 0,
            favoriteAmount: 0),
      ],
    );

    final errorMock = ErrorModel('Erro ao buscar motéis');

    blocTest<MotelsCubit, MotelsState>(
      'Emite [loading, success] quando getAllPaginated() retorna dados com sucesso',
      build: () {
        when(() => motelsRepository.getAllPaginated())
            .thenAnswer((_) async => DefaultResponseModel(data: mockMotels));
        return motelsCubit;
      },
      act: (cubit) => cubit.getAllPaginated(),
      expect: () => [
        isA<MotelsState>()
            .having((e) => e.status.isLoading, 'isLoading', isTrue),
        isA<MotelsState>()
            .having((e) => e.status.isSuccess, 'isSuccess', isTrue)
            .having((e) => e.motels, 'Motels', equals(mockMotels))
      ],
    );

    blocTest<MotelsCubit, MotelsState>(
      'Emite [loading, error] quando getAllPaginated() falha',
      build: () {
        when(() => motelsRepository.getAllPaginated())
            .thenAnswer((_) async => DefaultResponseModel(error: errorMock));
        return motelsCubit;
      },
      act: (cubit) => cubit.getAllPaginated(),
      expect: () => [
        isA<MotelsState>()
            .having((e) => e.status.isLoading, 'isLoading', isTrue),
        isA<MotelsState>()
            .having((e) => e.status.isError, 'isError', isTrue)
            .having((e) => e.motels, 'Motels', isNull)
      ],
    );
  });
}
