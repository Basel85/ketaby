class CustomException implements Exception {
  final String errorMessage;
  final Map<String, dynamic> errors;
  CustomException({this.errorMessage = "", this.errors = const {}});
}
