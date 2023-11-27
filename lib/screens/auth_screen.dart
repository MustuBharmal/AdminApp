import 'package:admin/providers/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/global_variables.dart';
import '../models/states_dist_model.dart';

enum AuthUser {
  signIn,
  signUp,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AuthUser _user = AuthUser.signIn;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  String selectedState = '';
  String? selectedDist;
  List<StateModel> states = [];
  bool isObscure = true;

  @override
  void didChangeDependencies() {
    Provider.of<AdminProvider>(context).fetchData().then((data) {
      setState(() {
        states = data;
      });
    }).catchError((error) {
      print("Error to load data: $error");
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final isValid = _key.currentState!.validate();
    if (!isValid) {
      return;
    }
    _key.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_user == AuthUser.signIn) {
      try {
        final userCredentials = await firebase.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //..
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    } else {
      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'phoneNo': _phoneNoController.text,
          'dist': selectedDist!.toLowerCase(),
          'state': selectedState.toLowerCase(),
          'role': 'admin'
        });
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //..
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                _user == AuthUser.signIn ? signInForm() : signUpForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInForm() {
    final deviceSize = MediaQuery.of(context).size;
    return Form(
      key: _key,
      child: Column(
        children: [
          const SizedBox(height: 40),
          emailTextField(),
          const SizedBox(height: 20),
          passwordTextField(),
          const SizedBox(height: 20),
          if (_isLoading) const CircularProgressIndicator() else submitButton(),
          TextButton(
            onPressed: () {
              setState(() {
                _user = AuthUser.signUp;
              });
            },
            child: const Text("Create Account"),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GestureDetector(
                onTap: () {
                  MessageDialog messageDialog = MessageDialog(
                    dialogBackgroundColor: Colors.white,
                    buttonOkColor: ThemeColor.primary,
                    title: 'Forgot password?',
                    titleColor: Colors.black,
                    message: 'Contact: adminmustafa@gmail.com',
                    messageColor: Colors.black,
                    buttonOkText: 'Ok',
                    dialogRadius: 30.0,
                    buttonRadius: 15.0,
                  );
                  messageDialog.show(context, barrierColor: Colors.white);
                },
                child: Text(
                  "Forgot password?",
                  style: normalStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            "Signup Here",
            style: normalStyle,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
          key: _key,
          child: Column(
            children: [
              emailTextField(),
              const SizedBox(height: 20),
              Row(
                children: [
                  addPadding(
                    const Icon(
                      Icons.account_circle,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (_nameController.text.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                      style: fieldStyle,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      cursorColor: ThemeColor.primary,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        fillColor: ThemeColor.textFieldBgColor,
                        filled: true,
                        hintText: "Enter the Full Name",
                        hintStyle: hintStyle,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _nameController.clear();
                            },
                            icon: const Icon(Icons.cancel)),
                        label: const Text("Name"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  addPadding(
                    const Icon(
                      Icons.phone,
                      size: 35,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (_phoneNoController.text.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                      maxLength: 10,
                      style: fieldStyle,
                      textInputAction: TextInputAction.next,
                      controller: _phoneNoController,
                      cursorColor: ThemeColor.primary,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        fillColor: ThemeColor.textFieldBgColor,
                        filled: true,
                        hintText: "Enter the Phone number",
                        hintStyle: hintStyle,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _phoneNoController.clear();
                            },
                            icon: const Icon(Icons.cancel)),
                        label: const Text("Phone"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              stateDropdown(),
              const SizedBox(height: 20),
              distDropdown(),
              const SizedBox(height: 20),
              passwordTextField(),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                submitButton(),
              TextButton(
                onPressed: () {
                  setState(() {
                    _user = AuthUser.signIn;
                  });
                },
                child: const Text("Already a user"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget emailTextField() {
    return Row(
      children: [
        addPadding(
          const Icon(
            Icons.account_circle,
            size: 35,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: (val) {
              if (_emailController.text.isEmpty) {
                return "This field can't be empty";
              }
              return null;
            },
            style: fieldStyle,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: _emailController,
            cursorColor: ThemeColor.primary,
            decoration: InputDecoration(
              fillColor: ThemeColor.textFieldBgColor,
              filled: true,
              hintStyle: hintStyle,
              hintText: 'E-mail',
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 20,
                ),
                onPressed: () {
                  _emailController.clear();
                },
              ),
              labelText: 'E-mail',
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordTextField() {
    return Row(
      children: [
        addPadding(
          const Icon(
            Icons.password_rounded,
            size: 35,
          ),
        ),
        Expanded(
          child: TextFormField(
            validator: (val) {
              if (_passwordController.text.isEmpty ||
                  _passwordController.text.length < 6) {
                return 'Enter valid password';
              }
              return null;
            },
            controller: _passwordController,
            obscureText: isObscure,
            style: fieldStyle,
            cursorColor: ThemeColor.primary,
            decoration: InputDecoration(
              fillColor: ThemeColor.textFieldBgColor,
              filled: true,
              hintStyle: hintStyle,
              hintText: "Enter the password",
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility)),
              label: const Text("Password"),
            ),
          ),
        ),
      ],
    );
  }

  Widget stateDropdown() {
    return Row(
      children: [
        addPadding(
          const Icon(
            Icons.location_city,
            size: 35,
          ),
        ),
        Expanded(
          child: DropdownButtonFormField(

            decoration: InputDecoration(
              fillColor: ThemeColor.textFieldBgColor,
              filled: true,
              hintText: ('Select State'),
              hintStyle: hintStyle,
            ),
            isExpanded: true,
            onChanged: (selectedValue) {
              setState(() {
                selectedState = selectedValue!;
                selectedDist = null;
              });
            },
            items: states
                .map(
                  (state) => DropdownMenuItem<String>(
                value: state.name,
                child: Text(
                  state.name,
                  style: dropdownStyle,
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget distDropdown() {
    return Row(
      children: [
        addPadding(
          const Icon(
            Icons.location_city,
            size: 35,
          ),
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              fillColor: ThemeColor.textFieldBgColor,
              filled: true,
              hintText: "Select your district",
              hintStyle: hintStyle,
              label: const Text("Select District"),
            ),
            isExpanded: true,
            value: selectedDist,
            items: selectedState == ''
                ? []
                : states
                .firstWhere((state) => state.name == selectedState)
                .dist
                .map(
                  (district) => DropdownMenuItem<String>(
                value: district,
                child: Text(
                  district,
                  style: dropdownStyle,
                ),
              ),
            )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedDist = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: _submit,
      child: Text(_user == AuthUser.signIn ? 'Login' : 'Signup'),
    );
  }

  Widget addPadding(Widget data) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: data,
    );
  }
}
