import 'package:api_demo/screens/home_screen.dart';
import 'package:api_demo/screens/login_screen.dart';
import 'package:api_demo/view_models/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LoginPageViewModel(),
        ),
      ],
      child: Consumer<LoginPageViewModel>(
        builder: (ctx, loginScreenViewModel, _) => MaterialApp(
          theme: ThemeData(
            fontFamily: 'Nunito',
          ),
          home: FutureBuilder(
            future: loginScreenViewModel.isShowHomePage(),
            builder: (ctx, AsyncSnapshot<bool>  loginResultSnapshot) {
              if(loginResultSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }else{
                if(loginResultSnapshot.data != null && loginResultSnapshot.data == true){
                  return const HomeScreen();
                }else{
                  return const LoginScreen();
                  //return const ConfigurationPage();
                }
              }
            },
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),

          },
        ),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or simply save your changes to "hot reload" in a Flutter IDE).
    //     // Notice that the counter didn't reset back to zero; the application
    //     // is not restarted.
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: ,
    // );
  }
}

