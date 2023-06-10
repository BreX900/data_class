import 'package:mek_data_class/mek_data_class.dart';

part 'generics_example.g.dart';

@DataClass(changeable: true, copyable: true)
sealed class Response<T> with _$Response<T> {
  final T data;

  const Response({
    required this.data,
  });
}

@DataClass(changeable: true, copyable: true)
final class PaginatedResponse<T extends Object> extends Response<T> with _$PaginatedResponse<T> {
  final int total;

  const PaginatedResponse({
    required T data,
    required this.total,
  }) : super(data: data);
}

@DataClass(changeable: true, copyable: true)
base class ListResponse<T> extends Response<List<T>> with _$ListResponse<T> {
  ListResponse({
    required List<T> data,
  }) : super(data: data);
}
