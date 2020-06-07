import 'package:shared_preferences/shared_preferences.dart';

setLoginData(res) async{
  print(res);

  SharedPreferences data = await SharedPreferences.getInstance();

  await data.setString('jwt', res['token']);
  await data.setString('username', res['username']);
  await data.setInt('id', res['id']);

  return data;
}