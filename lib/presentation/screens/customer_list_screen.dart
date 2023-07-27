import 'package:flutter/material.dart';
import 'package:radarsoft_app/services/customer_services.dart';
import 'package:radarsoft_app/models/customer.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Customer>>(
      future: CustomerService.fetchCustomers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is loading, show a progress indicator.
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If the future failed, show an error message.
          return const Center(child: Text('Failed to load data'));
        } else if (snapshot.hasData) {
          // If the future completed successfully, display the data.
          final customers = snapshot.data!;
          return Container(
            margin: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    '${customer.name} ${customer.lName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${customer.email ?? 'N/A'}'),
                      Text('Phone Number: ${customer.phoneNumber}'),
                    ],
                  ),
                  onTap: () {},
                );
              },
            ),
          );
        } else {
          // The future is null, likely no data.
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
