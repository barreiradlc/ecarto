import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Funcoes/Fetch.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var currentPassword = TextEditingController(text: '');

  var newPassword = TextEditingController(text: '');
  var newPasswordConfirm = TextEditingController(text: '');

  req() async {
    if(currentPassword.text == '' && newPassword.text == '' && newPasswordConfirm.text == '' ){
      return Get.snackbar("Atenção!", "Preencha com seus dados para continuar!");
    }

    if (newPassword.text == newPasswordConfirm.text) {
      var response = await newPasswordCall(currentPassword.text, newPassword.text);

      print(response);

      if (response.statusCode == 200) {
        Get.back();
        return Get.snackbar("Sucesso!", "Senha alterada com sucesso!");
      } else {
        return Get.snackbar("Atenção!",
            "Houve algum problema ao alterar sua senha, verifique suas credenciais!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text("Alterar senha", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: currentPassword,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) =>
                    FocusScope.of(context).nextFocus(), // move focus to next
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  labelText: 'Senha atual',
                ),
                autofocus: true,
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: newPassword,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) =>
                    FocusScope.of(context).nextFocus(), // move focus to next
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  labelText: 'Nova senha',
                ),
                autofocus: true,
              )),
          Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: newPasswordConfirm,
                onSubmitted: (_) =>
                    FocusScope.of(context).nextFocus(), // move focus to next
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  labelText: 'Confirme nova senha',
                ),
                autofocus: true,
              )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(25),
                  onPressed: req,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Text("Enviar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ))),
        ],
      )),
    );
  }
}
