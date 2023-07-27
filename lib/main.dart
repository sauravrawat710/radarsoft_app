import 'package:flutter/material.dart';
import 'package:radarsoft_app/presentation/screens/customer_list_screen.dart';
import 'package:radarsoft_app/presentation/widgets/create_customer_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Customer List')),
        body: const CustomerListScreen(),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const CreateCustomerForm();
                },
              );
            },
            label: const Text('Create New Customer'),
          );
        }),
      ),
    );
  }
}
