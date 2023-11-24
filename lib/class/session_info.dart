class SessionInfo {
  SessionInfo({
    required this.accountId,
    required this.requestToken,
    required this.sessionId,
  });

  String requestToken;
  String sessionId;
  int accountId;

  String? id;

  // Add the fromJson method
  factory SessionInfo.fromJson(Map<String, dynamic> json) {
    return SessionInfo(
      accountId: json['accountId'],
      requestToken: json['requestToken'],
      sessionId: json['sessionId'],
    );
  }

  // Add the toJson method
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'requestToken': requestToken,
      'sessionId': sessionId,
    };
  }
}
