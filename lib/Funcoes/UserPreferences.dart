import 'package:shared_preferences/shared_preferences.dart';

setLoginData(res) async{
  print(res);
  print(res['token']);

  SharedPreferences data = await SharedPreferences.getInstance();

  await data.setString('jwt', res['token']);
  await data.setString('username', res['username']);
  await data.setString('id', res['id']);

  return data;
}

removeLoginData() async{  

  SharedPreferences data = await SharedPreferences.getInstance();

  await data.remove('jwt');
  await data.remove('username');
  await data.remove('id');

  return data;
}