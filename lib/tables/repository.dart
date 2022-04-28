abstract class Repository<T> {
  Future<List<T>> loadMore();

  int pageSize = 100;
  int loadedCount = 0;
  String lastKey = '';

  int get totalCount;
}
