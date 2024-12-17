class LocalUserModel {
  final int id; // SQLite primary key
  final String name;
  final String email;
  final String birthDate;
  final int pledgedGifts;

  LocalUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.pledgedGifts,
  });

  // Convert LocalUserModel to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'pledgedGifts': pledgedGifts,
    };
  }

  // Create LocalUserModel from SQLite row
  factory LocalUserModel.fromMap(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      birthDate: map['birthDate'],
      pledgedGifts: map['pledgedGifts'],
    );
  }
}
