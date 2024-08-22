class RegistrationModel {
  final int status;
  final String message;
  final String? token; // Nullable as it is only present in success response
  final Map<String, List<String>>? errorDetails; // Nullable as it is only present in error response

  RegistrationModel({
    required this.status,
    required this.message,
    this.token,
    this.errorDetails,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      status: json['status'],
      message: json['message'] is String ? json['message'] : '',
      token: json['token'],
      errorDetails: json['message'] is Map<String, dynamic>
          ? _parseErrorDetails(json['message'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': errorDetails ?? message,
      'token': token,
    };
  }

  // Helper function to parse error details
  static Map<String, List<String>> _parseErrorDetails(Map<String, dynamic> errorMessage) {
    final Map<String, List<String>> errorDetails = {};
    errorMessage.forEach((key, value) {
      if (value is List<dynamic>) {
        errorDetails[key] = List<String>.from(value.map((item) => item.toString()));
      }
    });
    return errorDetails;
  }
}
