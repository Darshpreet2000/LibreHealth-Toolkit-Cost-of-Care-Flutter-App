import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:curativecare/bloc/download_cdm_bloc/download_cdm_progress/bloc.dart';
import 'package:curativecare/repository/download_cdm_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockDownloadCDMRepoImpl extends Mock
    implements DownloadCDMRepositoryImpl {}

void main() {
  MockDownloadCDMRepoImpl mockDownloadCDMRepoImpl;
  DownloadFileButtonBloc downloadFileButtonBloc;
  setUp(() {
    mockDownloadCDMRepoImpl = MockDownloadCDMRepoImpl();
    downloadFileButtonBloc = DownloadFileButtonBloc(mockDownloadCDMRepoImpl);
  });

  tearDown(() {
    downloadFileButtonBloc?.close();
  });
  test('initial state is correct', () {
    expect(
        downloadFileButtonBloc.initialState, InitialDownloadFileButtonState());
  });
  Stream<FileResponse> fileStream = new Stream.empty();

  group('DownloadProgressBloc test', () {
    blocTest(
      'emits [InitialDownloadFileButtonState(),DownloadButtonLoadingCircular(),DownloadButtonStream()] when DownloadFileButtonClick is added',
      build: () {
        when(mockDownloadCDMRepoImpl.getFileSize(any))
            .thenAnswer((realInvocation) => Future.value(100.00));
        when(mockDownloadCDMRepoImpl.downloadCDM(any))
            .thenAnswer((realInvocation) => Future.value(fileStream));

        return downloadFileButtonBloc;
      },
      act: (bloc) => bloc.add(DownloadFileButtonClick(
          0,
          "Alaska Regional Hospital",
          "Alaska",
          DownloadFileButtonBloc(mockDownloadCDMRepoImpl))),
      expect: [
        DownloadButtonLoadingCircular(0),
        DownloadButtonStream(fileStream, 0, 100.00)
      ],
    );
    blocTest(
      'emits [InitialDownloadFileButtonState(),DownloadButtonErrorState("")] when DownloadFileButtonClick is added',
      build: () {
        when(mockDownloadCDMRepoImpl.getFileSize(any))
            .thenThrow(Exception("Network Problem"));
        when(mockDownloadCDMRepoImpl.downloadCDM(any))
            .thenAnswer((realInvocation) => Future.value(fileStream));
        return downloadFileButtonBloc;
      },
      act: (bloc) => bloc.add(DownloadFileButtonClick(
          0,
          "Alaska Regional Hospital",
          "Alaska",
          DownloadFileButtonBloc(mockDownloadCDMRepoImpl))),
      expect: [
        DownloadButtonLoadingCircular(0),
        DownloadButtonErrorState("Network Problem")
      ],
    );
  });
}
