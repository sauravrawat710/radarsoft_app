import 'package:dio/dio.dart';
import 'package:radarsoft_app/models/customer.dart';

class CustomerService {
  static const String baseUrl = 'http://151.106.113.31:5000/api/customers';
  static Future<List<Customer>> fetchCustomers() async {
    final response = await Dio().get(baseUrl);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      try {
        final List data = response.data;
        final List<Customer> customers =
            data.map((json) => Customer.fromJson(json)).toList();

        return customers;
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> addCustomer({
    required String name,
    required String lName,
    required int phoneNumber,
    required String email,
  }) async {
    try {
      final response = await Dio().post(
        baseUrl,
        data: {
          "fname": name,
          "lname": lName,
          "phone": phoneNumber,
          "email": email,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 201) {
        // If the server returns a 201 OK response, Customer got created.
        return true;
      } else {
        print('dfnvldfindoifv');
        throw Exception('Failed to create customer');
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        return false;
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
