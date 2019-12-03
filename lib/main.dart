import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 25) {
        _infoText = "Peso normal(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Acima do peso(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obesidade I(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Obesidade II(${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade III(${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.lightGreen,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.lightGreen)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.lightGreen)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.lightGreen,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                ),
              ],
            ),
          )),
    );
  }
}
