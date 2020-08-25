import 'package:bloc_test/bloc_test.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_bloc.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_event.dart';
import 'package:cost_of_care/bloc/home_settings_bloc/home_settings_state.dart';
import 'package:cost_of_care/models/home_settings_model.dart';
import 'package:cost_of_care/repository/home_settings_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeSettingRepository extends Mock implements HomeSettingsRepoImpl {}

void main() {
  HomeSettingsBloc homeSettingsBloc;
  MockHomeSettingRepository homeSettingRepository;
  setUp(() {
    homeSettingRepository = MockHomeSettingRepository();
    homeSettingsBloc = HomeSettingsBloc(homeSettingRepository);
  });
  tearDown(() {
    homeSettingsBloc?.close();
  });

  test('initial state is correct', () {
    expect(homeSettingsBloc.initialState, HomeSettingsLoadingState());
  });
  HomeSettingsModel homeSettingsModel =
      new HomeSettingsModel(15, 'Ascending', true, 123, 123, "", "");
  HomeSettingsModel homeSettingsModelChangedOrder =
      new HomeSettingsModel(15, 'Descending', true, 123, 123, "", "");

  group('Bloc test', () {
    blocTest(
      'emits [HomeSettingsLoadedState(HomeSettingsModel(15,Ascending,true))] when GetInitialSettings is added',
      build: () {
        when(homeSettingRepository.getInitialSettings())
            .thenAnswer((realInvocation) => homeSettingsModel);
        return homeSettingsBloc;
      },
      act: (bloc) => bloc.add(GetInitialSettings()),
      expect: [HomeSettingsLoadedState(homeSettingsModel)],
    );
    blocTest(
      'emits [HomeSettingsLoadedState(HomeSettingsModel(15,Descending,true))] when ToggleOrder is added',
      build: () {
        when(homeSettingRepository.getInitialSettings())
            .thenAnswer((realInvocation) => homeSettingsModel);
        return homeSettingsBloc;
      },
      act: (bloc) => bloc.add(ToggleOrder(homeSettingsModel)),
      expect: [HomeSettingsLoadedState(homeSettingsModelChangedOrder)],
    );
  });
}
