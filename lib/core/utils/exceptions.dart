class AuthException implements Exception {
  final String errorMessage;
  final Map<String, dynamic> errors;
  AuthException({required this.errorMessage,required this.errors});
}
