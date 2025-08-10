class UserProfile {
  final String id;
  final String name;
  final String phone;
  final double rating;
  final bool isDriver;

  const UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.rating,
    required this.isDriver,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        rating: (json['rating'] as num).toDouble(),
        isDriver: json['is_driver'] as bool,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'rating': rating,
        'is_driver': isDriver,
      };
}