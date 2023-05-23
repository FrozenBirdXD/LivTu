class GlobalUserException implements Exception {
  const GlobalUserException();
}

class CouldNotUpdatePhotoURL implements GlobalUserException {}

class CouldNotUpdateDisplayName implements GlobalUserException {}

class CloudNotUpdateIconURL implements GlobalUserException {}

class CouldNotUpdateDescription implements GlobalUserException {}

class GlobalUserNotFound implements GlobalUserException {}


class CouldNotGetDisplayName implements GlobalUserException {}