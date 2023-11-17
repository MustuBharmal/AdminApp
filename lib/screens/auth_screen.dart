import 'package:admin/providers/admin_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late Animation<Size> _heightAnimation;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  String selectedState = '';
  String? selectedDist;
  List<StateModel> states = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
      vsync: this,
    );
    _heightAnimation = Tween<Size>(
      begin: const Size(
        double.infinity,
        430,
      ),
      end: const Size(
        double.infinity,
        260,
      ),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _heightAnimation.addListener(() => setState(() {}));
    _opacityAnimation = Tween<double>(begin: 200, end: 320).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

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
          'role':'admin'
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  // bottom: 20,
                  right: 20,
                  left: 20,
                ),
                width: 210,
                child: Image.asset(
                  "assets/images/admin_app_logo.png",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _user == AuthUser.signIn ? signInForm() : signUpForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget signInForm() {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: const Color(0xffE0F4FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8.0,
      child: AnimatedBuilder(
        animation: _heightAnimation,
        builder: (ctx, ch) => Container(
          height: _heightAnimation.value.height,
          constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
          width: deviceSize.width * 0.9,
          padding: const EdgeInsets.all(16.0),
          child: ch,
        ),
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                emailTextField(),
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
                      _user = AuthUser.signUp;
                    });
                  },
                  child: const Text("Create Account"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot your password?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
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
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _nameController.clear();
                          },
                          icon: const Icon(Icons.cancel)),
                      label: const Text("Name"),
                      hintText: "Enter the Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
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
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your phone';
                      }
                      return null;
                    },
                    controller: _phoneNoController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _phoneNoController.clear();
                          },
                          icon: const Icon(Icons.cancel)),
                      label: const Text("Phone"),
                      hintText: "enter the Phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                      ),
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
              if (val == null || val.isEmpty) {
                return 'Enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(21),
                borderSide: const BorderSide(
                  width: 3,
                ),
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
              if (val == null || val.isEmpty || val.length < 6) {
                return 'Enter valid password';
              }
              return null;
            },
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    _passwordController.clear();
                  },
                  icon: const Icon(Icons.cancel)),
              label: const Text("Password"),
              hintText: "Enter the password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(21),
              ),
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
            hint: const Text('Select State'),
            isExpanded: true,
            onChanged: (selectedValue) {
              setState(() {
                selectedState = selectedValue!;
                selectedDist = '';
              });
            },
            items: states
                .map(
                  (state) => DropdownMenuItem<String>(
                    value: state.name,
                    child: Text(state.name),
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
            isExpanded: true,
            hint: const Text('Rajkot'),
            items: selectedState == ''
                ? []
                : states
                    .firstWhere((state) => state.name == selectedState)
                    .dist
                    .map(
                      (district) => DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
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
            borderRadius: BorderRadius.circular(21),
          ),
        ),
      ),
      onPressed: _submit,
      child: Text(_user == AuthUser.signIn ? 'LogIn' : 'SignUp'),
    );
  }

  Widget addPadding(Widget data) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: data,
    );
  }
}
