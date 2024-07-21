import 'package:shopapplication/modules/login/shop_login_screen.dart';
import 'package:shopapplication/shared/components/components.dart';
import 'package:shopapplication/shared/network/local/cashe_helper.dart';

void signOut(context){
  SharedPrefrenceHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=>print(element.group(0)));
}

String token='';