class Profile {
  final String name;
  final String email;
  final String phone;
  final String address;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Profile.fromMap(Map<String, dynamic> data) {
    return Profile(
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      address: data['address'],
    );
  }
}