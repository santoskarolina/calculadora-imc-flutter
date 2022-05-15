import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController wigthController = TextEditingController();
  TextEditingController heighController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _info = '';

  void _resetField() {
    wigthController.text = '';
    heighController.text = '';
  }

  void calculate() {
    setState(() {
      double wigth = double.parse(wigthController.text);
      double heigth = double.parse(heighController.text) / 100;
      double imc = wigth / (heigth * heigth);

      if (imc <= 16.9) {
        _info = "Muito abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc > 17 && imc < 18.4){
        _info = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc > 18.5 && imc < 24.9){
        _info = "Peso normal (${imc.toStringAsPrecision(3)})";
      }else if(imc > 25 && imc < 29.9){
        _info = "Acima do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc > 30 && imc < 34.9){
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }else if(imc > 35 && imc < 40){
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      }else if(imc > 40){
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }else{
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
      _showDialog();
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: const Text(
            "Resultado",
            style: TextStyle(fontSize: 25),
          ),
          content: Text(
            _info,
            style: const TextStyle(fontSize: 25),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  fixedSize: const Size(100, 60),
                  primary: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculadora de IMC',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[700],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                Container(
                height: 180,
                alignment: Alignment.center, // This is needed
                child: Image.asset(
                  'assets/img.png',
                    fit: BoxFit.contain,
                ),
              ),
                const SizedBox(height: 10,), //espaçamento entre os botoes
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso em kg",
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.blue[700]),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue[700], fontSize: 30),
                    controller: wigthController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Insira seu peso";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura em cm",
                      border: const OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.blue[700]),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue[700], fontSize: 30),
                    controller: heighController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Insira sua altura";
                      }else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: TextButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        calculate();
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        fixedSize: const Size(300, 60),
                        primary: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                  child: TextButton(
                    onPressed: _resetField,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        fixedSize: const Size(300, 60),
                        primary: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                    child: const Text(
                      'Limpar',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
