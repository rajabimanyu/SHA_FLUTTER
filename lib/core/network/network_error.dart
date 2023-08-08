class NetworkError<T> {
  final T? data;
  final String message;

  const NetworkError({
    required this.message,
    this.data,
  });
}
