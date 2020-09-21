import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/refresh_saved_cdm_bloc/refresh_saved_cdm_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RefreshSavedCdmBloc refreshSavedCdmBloc;

  setUp(() {
    refreshSavedCdmBloc = RefreshSavedCdmBloc();
  });
  tearDown(() {
    refreshSavedCdmBloc?.close();
  });

  test('initial state is correct', () {
    expect(refreshSavedCdmBloc.initialState, RefreshSavedCdmInitial());
  });
  group('refreshSavedCdmBloc test', () {
    blocTest(
      'emits [RefreshSavedCdmStart(),] when RefreshCDMEventStart is added',
      build: () {
        return refreshSavedCdmBloc;
      },
      act: (bloc) => bloc.add(RefreshCDMEventStart()),
      expect: [RefreshSavedCdmStart()],
    );
    blocTest(
      'emits [RefreshSavedCdmCompleted(),] when RefreshCDMEventCompleted is added',
      build: () {
        return refreshSavedCdmBloc;
      },
      act: (bloc) => bloc.add(RefreshCDMEventCompleted()),
      expect: [RefreshSavedCdmCompleted()],
    );
    blocTest(
      'emits [RefreshSavedCdmError(),] when RefreshCDMEventError is added',
      build: () {
        return refreshSavedCdmBloc;
      },
      act: (bloc) => bloc.add(RefreshCDMEventError("Error Message")),
      expect: [RefreshSavedCdmError("Error Message")],
    );
  });
}
