class Customer {
  final int id;
  final String name;
  final String lName;
  final String phoneNumber;
  final String? email;
  final String createdDate;
  final DateTime? updatedDate;
  final int isActive;
  final String fcmToken;
  final int isScanned;
  final int? bookCount;

  Customer({
    required this.id,
    required this.name,
    required this.lName,
    required this.phoneNumber,
    this.email,
    required this.createdDate,
    this.updatedDate,
    required this.isActive,
    required this.fcmToken,
    required this.isScanned,
    this.bookCount,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json['id'],
        name: json['fname'],
        lName: json['lname'],
        phoneNumber: json['phone'],
        email: json['email'],
        createdDate: json['createdDate'],
        updatedDate: json['updatedDate'] != null
            ? DateTime.parse(json['updatedDate'])
            : null,
        isActive: json['isActive'],
        fcmToken: json['fcm_token'],
        isScanned: json['isScanned'],
        bookCount: json['bookCount'],
      );
}
