class DataResponse<T, E extends Error> {
  final T? data;
  final E? error;
  final bool success;

  const DataResponse.completed(this.data)
      : error = null,
        success = true;

  const DataResponse.error(this.error)
      : data = null,
        success = false;
}