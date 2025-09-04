import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    //para obtener el tamaño de pantalla del dispositivo
    final Size size = MediaQuery.of(context).size;

    
    return Scaffold(  //Scaffold significa en espaol andamio
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),  
          child: Column(
            //axis o eje principal
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                //ancho de la pantalla calulado por mediaquery
                width: size.width,
                height: 200,
                child: const RiveAnimation.asset('animated_login_character.riv')
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",//hintText que significa texto de sugerencia
                    prefixIcon: const Icon(Icons.mail), //lo primero que se ve en tu pantalla de donde escribes
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                    
                  ),
                  
                ),
                SizedBox(height: 10),
                TextField(
                  //para que no se vea la contraseña
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: _togglePasswordView,
                child: Icon(
                   _isHidden ? Icons.visibility : Icons.visibility_off,
                ),
                    ),//hintText que significa texto de sugerencia
                    prefixIcon: const Icon(Icons.lock), //lo primero que se ve en tu pantalla de donde escribes
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                    
                  ),
                  
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width,
                  child: const Text(
                    "Forgot password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                )
                
            ],
          ),
        )),
    );  
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}