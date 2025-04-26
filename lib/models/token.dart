class Token {
  final String displayName;
  final String userId;
  final String token;

  const Token({required this.displayName, required this.userId, required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': 'success',
        'users': {
          'userID': String userId,
          'display_name': String displayName,
          'token': String token
        }
      } =>
        Token(
          displayName: displayName,
          userId: userId,
          token: token,
        ),
      _ => throw const FormatException('Failed to load token.'),
    };
  }
}
