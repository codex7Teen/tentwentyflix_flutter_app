class UserFriendlyErrorMapper {
  /// Maps technical error messages to user-friendly messages
  static String mapErrorMessage(String originalError) {
    // Network-related errors
    if (originalError.contains('SocketException') ||
        originalError.contains('Failed to connect')) {
      return 'Unable to connect to the internet. Please check your network connection.';
    }

    // API and Authentication Errors
    if (originalError.contains('401') ||
        originalError.contains('Unauthorized')) {
      return 'Authentication failed. Please log in again.';
    }

    if (originalError.contains('403') || originalError.contains('Forbidden')) {
      return 'You do not have permission to access this content.';
    }

    if (originalError.contains('404') || originalError.contains('Not Found')) {
      return 'The requested content could not be found.';
    }

    // Timeout errors
    if (originalError.contains('TimeoutException') ||
        originalError.contains('Timeout')) {
      return 'The request took too long. Please try again later.';
    }

    // Data parsing errors
    if (originalError.contains('FormatException') ||
        originalError.contains('parse error')) {
      return 'We encountered an issue processing the data. Please try again.';
    }

    // API-specific errors
    if (originalError.contains('Invalid API key')) {
      return 'There was a problem with the app\'s connection. Please contact support.';
    }

    // Generic network errors
    if (originalError.contains('No Internet')) {
      return 'No internet connection. Please check your network and try again.';
    }

    // Generic catch-all for other errors
    if (originalError.toLowerCase().contains('error')) {
      return 'An unexpected error occurred. Please try again.';
    }

    // If no specific mapping is found, return a generic message
    return 'Something went wrong. Please try again later.';
  }

  /// Logs the original error for debugging while returning a user-friendly message
  static String logAndMapError(String originalError) {
    // TODO: Implement proper logging mechanism
    print('Original Error: $originalError');
    return mapErrorMessage(originalError);
  }
}
