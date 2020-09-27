import 'package:intl/intl.dart';

convertDatetimetoPT(date){
    print(date);

    return DateFormat('dd/MM/y kk:mm').format(date);
}