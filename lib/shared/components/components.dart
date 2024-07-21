import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType Type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: Type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false);

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

Widget defaultButton({required Function()? onPressed, required String text}) =>
    Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(3)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
Widget defaultTextButton(
        {required Function()? onPressed, required String text}) =>
    TextButton(onPressed: onPressed, child: Text(text.toUpperCase()));

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(model.image),
          fit: BoxFit.contain,
        )),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
void showToast({required String text,required ToastStates state}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
