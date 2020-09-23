import 'package:ecarto/Funcoes/Fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

setProfile(res) async{
  SharedPreferences data = await SharedPreferences.getInstance();

  String image = res['image'] != '' || res['image'] != null ? res['image'] : await getThumbPlaceholder();

  if(res['_id'] != null){
    await data.setString('id', res['_id']);
    await data.setString('username', res['username']);
  }

  await data.setString('email', res['email']);
  await data.setString('image', image);
  await data.setString('instagram', res['instagram']);
  await data.setString('name', res['name']);
  await data.setString('phone', res['phone']);
  await data.setString('about', res['about']);
}

getProfile() async{
  SharedPreferences data = await SharedPreferences.getInstance();

  var user = {
    'id': '',
    'username': '',
    'email': '',
    'image': '',
    'instagram': '',
    'name': '',
    'phone': '',
    'about': '',
  };

  user['id'] = data.getString('id');
  user['username'] = data.getString('username');
  user['email']  = data.getString('email');
  user['image']  = data.getString('image');
  user['instagram']  = data.getString('instagram');
  user['name']  = data.getString('name');
  user['phone']  = data.getString('phone');
  user['about']  = data.getString('about');

  return user;
}


setLoginData(res) async{
  print(res);
  print(res['token']);

  SharedPreferences data = await SharedPreferences.getInstance();

  await data.setString('jwt', res['token']);
  await data.setString('email', res['email']);
  await data.setString('username', res['username']);
  await data.setString('id', res['id']);

  return data;
}

removeLoginData() async{  

  SharedPreferences data = await SharedPreferences.getInstance();

  await data.remove('jwt');

  await data.remove('username');
  await data.remove('id');
  await data.remove('email');
  await data.remove('image');
  await data.remove('instagram');
  await data.remove('name');
  await data.remove('phone');
  await data.remove('about');

  return data;
}