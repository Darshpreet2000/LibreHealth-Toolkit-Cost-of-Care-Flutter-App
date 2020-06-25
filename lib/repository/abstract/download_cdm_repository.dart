abstract class DownloadCDMRepository {
  Future fetchData(String stateName);

  void saveData(List<String> hospitalsName);
}
