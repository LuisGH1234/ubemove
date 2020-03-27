mixin BaseEvent {
  bool loading = false;
  String code;
  bool error = false;
  String message;
}

abstract class SinglePayload<T> {
  T value;
}

abstract class ListPayload<T> {
  List<T> data = [];
}

abstract class Process {
  bool success = false;
}

abstract class ListPaginatedPayload<T> extends ListPayload<T> {
  int totalPages;
  int totalItems;
  int page;
  bool hasPrevPage = false;
  bool hasNextPage = false;
  num montoTotal;
}
