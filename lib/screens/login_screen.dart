import 'package:api_demo/model/login_submit_username_response.dart';
import 'package:api_demo/repo/NetworkException.dart';
import 'package:api_demo/screens/home_screen.dart';
import 'package:api_demo/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {'email': ''};
  var _isLoading = false;

  // TextEditingController email_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // controller: email_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email'
                ),
                validator: (value){
                  bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                  if (value == null || value.isEmpty) {
                    return 'Email Address cannot be empty.';
                  }else if(!isValidEmail){
                    return 'Check your email address.';
                  }
                  return null;
                },
                onChanged: (value){
                 _formData['email']=value;
                },
              ),
              SizedBox(height: 20,),
              _isLoading==true?CircularProgressIndicator():OutlinedButton(onPressed: _onPressed, child: Text('Sign In'))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await Provider.of<LoginPageViewModel>(context, listen: false)
            .loginSubmitUsernameRequest(_formData['email']);
        if(response != null && response is LoginSubmitUsernameVo ) {
          LoginSubmitUsernameVo res=response as LoginSubmitUsernameVo;
          if(res.loginCodeIsRequired==true) {
            Navigator.of(context)
                .pushNamed(
                HomeScreen.routeName);
          }
        }else if(response!=null && response is NetworkExceptions){
          _showErrorDialog("Exception occured:${(response as NetworkExceptions).errorMessage}");
        }else{
          _showErrorDialog("Unknown Exception occured:${response}");
        }
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        setState(() {});
        _showErrorDialog("Error : ${error.toString()}");
        return;
      }
    }
  }
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _isLoading = false;
              });

            },
          )
        ],
      ),
    );
  }
}
