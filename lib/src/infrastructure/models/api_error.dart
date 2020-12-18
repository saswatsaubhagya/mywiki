import 'dart:convert';

class ApiError {
  final String error;
  ApiError({
    this.error,
  });

  ApiError copyWith({
    String error,
  }) {
    return ApiError(
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ApiError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'error': error,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ApiError(
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source));
}
