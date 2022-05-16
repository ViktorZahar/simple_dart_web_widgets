abstract class Repository<T> {
  Future<List<T>> loadMore();

  int totalCount = 0;

  int pageSize = 100;
  int loadedCount = 0;
  String lastKey = '';

}
