// Model class for User
// This class represents a user in the Awakeia app
class User {
  final String id;
  final String email;
  final String? name;
  final DateTime createdAt;
  final bool isGuest;

  const User({
    required this.id,
    required this.email,
    this.name,
    required this.createdAt,
    this.isGuest = false,
  });

  // Factory constructor for creating a guest user
  factory User.guest() {
    return User(
      id: 'guest',
      email: 'guest@awakeia.com',
      name: 'Guest User',
      createdAt: DateTime.now(),
      isGuest: true,
    );
  }

  // Factory constructor for creating user from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isGuest: json['isGuest'] as bool? ?? false,
    );
  }

  // Convert user to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'isGuest': isGuest,
    };
  }

  // CopyWith method for creating modified copies of user
  User copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    bool? isGuest,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.isGuest == isGuest;
  }

  // Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        isGuest.hashCode;
  }

  // String representation
  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, createdAt: $createdAt, isGuest: $isGuest)';
  }
}

// Authentication state enum
enum AuthState {
  initial, // App just started
  loading, // Authentication in progress
  authenticated, // User is logged in
  unauthenticated, // User is not logged in
}

// Authentication status class
class AuthStatus {
  final AuthState state;
  final User? user;
  final String? error;

  const AuthStatus({
    required this.state,
    this.user,
    this.error,
  });

  // Factory constructors for different states
  factory AuthStatus.initial() {
    return const AuthStatus(state: AuthState.initial);
  }

  factory AuthStatus.loading() {
    return const AuthStatus(state: AuthState.loading);
  }

  factory AuthStatus.authenticated(User user) {
    return AuthStatus(
      state: AuthState.authenticated,
      user: user,
    );
  }

  factory AuthStatus.unauthenticated([String? error]) {
    return AuthStatus(
      state: AuthState.unauthenticated,
      error: error,
    );
  }

  // Convenience getters
  bool get isInitial => state == AuthState.initial;
  bool get isLoading => state == AuthState.loading;
  bool get isAuthenticated => state == AuthState.authenticated;
  bool get isUnauthenticated => state == AuthState.unauthenticated;

  // CopyWith method
  AuthStatus copyWith({
    AuthState? state,
    User? user,
    String? error,
  }) {
    return AuthStatus(
      state: state ?? this.state,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'AuthStatus(state: $state, user: $user, error: $error)';
  }
}
