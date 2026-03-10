import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final int age;
  final String gender;
  final double height;
  final double weight;
  final String bloodGroup;
  final DateTime createdAt;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bloodGroup,
    required this.createdAt,
  });

  // 1. Data Firestore bhejne ke liye
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'bloodGroup': bloodGroup,
      'createdAt': Timestamp.fromDate(createdAt), // Firestore Timestamp format
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? 'Other',
      height: (map['height'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      bloodGroup: map['bloodGroup'] ?? '',

      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
