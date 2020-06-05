mixin BaseEvent {
  bool loading = false;
  String code;
  bool error = false;
  String message;
}

abstract class SinglePayload<T> {
  final T value;

  SinglePayload({this.value});

  // factory SinglePayload.loading() {
  //   return SinglePayload(
  //     value: null,
  //   )..loading = true;
  // }

  // factory SinglePayload.success(T value) {
  //   return SinglePayload(
  //     value: value,
  //   );
  // }

  // factory SinglePayload.error(String message) {
  //   return SinglePayload(
  //     value: null,
  //   )
  //     ..error = true
  //     ..message = message;
  // }
}

class ListPayload<T> {
  final List<T> data;

  ListPayload({this.data = const []});

  // factory ListPayload.loading() {
  //   return ListPayload(
  //     data: const [],
  //   )..loading = true;
  // }

  // factory ListPayload.success(List<T> data) {
  //   return ListPayload(
  //     data: data,
  //   );
  // }

  // factory ListPayload.error(String message) {
  //   return ListPayload(
  //     data: [],
  //   )
  //     ..error = true
  //     ..message = message;
  // }
}

class Process {
  final bool success;

  Process({this.success = false});

  // factory Process.loading() {
  //   return Process(
  //     success: false,
  //   )..loading = true;
  // }

  // factory Process.success() {
  //   return Process(
  //     success: true,
  //   );
  // }

  // factory Process.error(String message) {
  //   return Process(
  //     success: false,
  //   )
  //     ..error = true
  //     ..message = message;
  // }
}

class ListPaginatedPayload<T> extends ListPayload<T> {
  final int totalPages;
  final int totalItems;
  final int page;
  final bool hasPrevPage; // = false;
  final bool hasNextPage; // = false;

  ListPaginatedPayload({
    List<T> data = const [],
    this.totalPages = 0,
    this.totalItems = 0,
    this.page = 0,
    this.hasNextPage = false,
    this.hasPrevPage = false,
  }) : super(data: data);

  // factory ListPaginatedPayload.loading() {
  //   return ListPaginatedPayload()..loading = true;
  // }

  // factory ListPaginatedPayload.success({
  //   List<T> data = const [],
  //   int totalPages = 0,
  //   int totalItems = 0,
  //   int page = 0,
  //   bool hasNextPage = false,
  //   bool hasPrevPage = false,
  // }) {
  //   return ListPaginatedPayload(
  //     data: data,
  //     hasNextPage: hasNextPage,
  //     hasPrevPage: hasPrevPage,
  //     page: page,
  //     totalItems: totalItems,
  //     totalPages: totalPages,
  //   );
  // }

  // factory ListPaginatedPayload.error(String message) {
  //   return ListPaginatedPayload()
  //     ..error = true
  //     ..message = message;
  // }
}
