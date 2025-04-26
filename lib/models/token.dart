class Token {
  final String accessToken;
  final String tokenType;

  const Token({required this.accessToken, required this.tokenType});

  factory Token.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'access_token': String accessToken, 'token_type': String tokenType} =>
        Token(
          accessToken: accessToken,
          tokenType: tokenType,
        ),
      _ => throw const FormatException('Failed to load token.'),
    };
  }
}
