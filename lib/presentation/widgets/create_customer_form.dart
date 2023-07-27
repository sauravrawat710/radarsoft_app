import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:radarsoft_app/services/customer_services.dart';

class CreateCustomerForm extends StatefulWidget {
  const CreateCustomerForm({super.key});

  @override
  CreateCustomerFormState createState() => CreateCustomerFormState();
}

class CreateCustomerFormState extends State<CreateCustomerForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  bool _isCreating = false;

  void addCustomer() {
    if (_formKey.currentState!.saveAndValidate()) {
      // Form is valid, perform the action here (e.g., save to database).
      Map<String, dynamic> formData = _formKey.currentState!.value;
      print(formData);
      setState(() {
        _isCreating = true;
      });
      try {
        CustomerService.addCustomer(
          name: formData['fname'],
          lName: formData['lname'],
          phoneNumber: int.parse(formData['phone']),
          email: formData['email'],
        ).then((value) {
          if (value) {
            setState(() {
              _isCreating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer created successfully'),
                backgroundColor: Colors.green,
              ),
            );
            CustomerService.fetchCustomers();
            Navigator.pop(context);
          } else {
            setState(() {
              _isCreating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer already exists'),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      } catch (e) {
        setState(() {
          _isCreating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('something went wrong'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Create New Customer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormField(
                      name: 'fname',
                      labelText: 'First Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      name: 'lname',
                      labelText: 'Last Name',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      name: 'phone',
                      labelText: 'Phone Number',
                      icon: Icons.phone,
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.maxLength(10),
                        FormBuilderValidators.minLength(10),
                      ],
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      name: 'email',
                      labelText: 'Email',
                      icon: Icons.email,
                      validators: [FormBuilderValidators.email()],
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _isCreating ? null : addCustomer,
                        child: Text(
                          _isCreating ? 'Creating...' : 'Create',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFormField({
  required String name,
  required String labelText,
  required IconData icon,
  List<FormFieldValidator<String?>>? validators,
  TextInputType keyboardType = TextInputType.text,
}) {
  return FormBuilderTextField(
    name: name,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    style: const TextStyle(fontSize: 16),
    keyboardType: keyboardType,
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.maxLength(50),
      ...validators ?? [],
    ]),
  );
}
