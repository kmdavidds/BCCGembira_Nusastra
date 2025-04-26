class Token {
  final String displayName;
  final String userId;
  final String token;

  const Token({required this.displayName, required this.userId, required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'display_name': String displayName,
        'userID': String userId,
        'token': String token
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
