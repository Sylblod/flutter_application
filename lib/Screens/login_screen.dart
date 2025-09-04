import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  //Cerebro de la logica de animacion
  StateMachineController? controller; //Controlador de la maquina de estados (veo loq ue este cabiando)
  SMIBool? isChecking; //Booleano que me dice si esta chequeando o no
  SMIBool? isHandsUp; //Booleano que me dice si las manos
  SMIBool? trigSuccess; //Booleano que me dice si tuvo exito
  SMIBool? trigFail; //Booleano que me dice si tuvo fracaso   
  SMINumber? numLook;



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
                child: RiveAnimation.asset('animated_login_character.riv',
                stateMachines: const ["Login Machine"],

                onInit: (artboard){ 
                  controller = StateMachineController.fromArtboard(artboard, "Login Machine");
                  if(controller == null) return;
                  artboard.addController(controller!);
                  isChecking = controller!.findSMI("isChecking");
                  isHandsUp = controller!.findSMI("isHandsUp");
                  trigSuccess = controller!.findSMI("trigSuccess");
                  trigFail = controller!.findSMI("trigFail");
                  numLook = controller!.findSMI('numLook');
                },)


                ), //Email
                SizedBox(height: 10),
                TextField(
                  /*onChanged: (value){
                    if (isHandsUp != null) {
                      isHandsUp!.change(false);
                    }
                    if (isChecking == null) return; 
                      isChecking!.change(true);
                    
                  },*/
                  onChanged: (value) {
                  // No suba las manos al escribir email
                  isHandsUp?.change(false);

                  // Activa "mirar"
                  isChecking?.change(true);

                  // Mueve los ojos dependiendo del tamaño del texto
                  if (numLook != null) {
                    numLook!.value = (value.length * 3).toDouble().clamp(0, 60);
                  }
                },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",//hintText que significa texto de sugerencia
                    prefixIcon: const Icon(Icons.mail), //lo primero que se ve en tu pantalla de donde escribes
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                    
                  ),
                  
                ), //password
                SizedBox(height: 10),
                TextField(
                  onChanged: (value){
                    if (isChecking != null) {
                      isChecking!.change(false);
                    }
                    if (isHandsUp == null) return; 
                      isHandsUp!.change(true);
                    
                  },
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
                ),
                //boton de login   04092025
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: (){},
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  minWidth: size.width,
                  height: 50,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: (){},
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                          //negriita
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                    
                  ],
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