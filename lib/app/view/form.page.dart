import 'package:flutter/material.dart';
import 'package:flutter_advanced_2025/app/constant/color.constant.dart';
import 'package:flutter_advanced_2025/app/widget/drawer.widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isFormValid = false;

  @override
  void initState(){
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    _fullNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose(){
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateForm(){
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  void _submit(){
    if(_isFormValid){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form has been submitted successfully'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: kShrineBrown900,
        backgroundColor: kShrinePink100,
        title: Text('Forms and Validation'),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty) return 'Email is required';
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if(!emailRegex.hasMatch(value)) return 'Enter valid email';
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value){
                    if(value != null && value.isNotEmpty){
                      final phoneRegex = RegExp(r'^(\+?6?01)[0|1|2|3|4|6|7|8|9]\-*[0-9]{7,8}$');
                      if(!phoneRegex.hasMatch(value)) return 'Enter valid phone numner';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _isFormValid ? _submit : null, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                  disabledForegroundColor: Colors.black
                ),
                child: const Text('Submit'),
              )
            ],
          )
        ),
      ),
    );
  }
}