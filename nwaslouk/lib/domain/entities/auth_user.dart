class AuthUser {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? location;
  final bool isDriver;
  final String authProvider;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.location,
    this.isDriver = false,
    required this.authProvider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['_id'] ?? json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      location: json['location'],
      isDriver: json['isDriver'] ?? false,
      authProvider: json['authProvider'] ?? 'local',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'location': location,
      'isDriver': isDriver,
      'authProvider': authProvider,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AuthUser copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? location,
    bool? isDriver,
    String? authProvider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      isDriver: isDriver ?? this.isDriver,
      authProvider: authProvider ?? this.authProvider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}