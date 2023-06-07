import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/style/icon_broken.dart';

import '../style/colors.dart';

Widget defaultTextButton({
  @required Function onPressed,
  @required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultButton({
  @required Function onPressed,
  @required String text,
  double Width = double.infinity,
  double height = 40.0,
  Color backgroundColor = defaultColor,
  double radius = 15.0,
  bool isUpperCase = true,
}) =>
    Container(
      width: Width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context,);
        },
        icon: Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      actions: actions,
      title: Text(title,),
      titleSpacing: 5.0,

    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false);
}

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void showToast({@required String msg, @required color}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget buildListItem(
  model,
  context, {
  bool isOldPrice = true,
  bool isFavorite = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Container(
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.price.round()}',
                          style: TextStyle(
                            color: defaultColor,
                            fontSize: 12.0,
                          )),
                      SizedBox(
                        width: 10.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      // if (AppCubit.get(context).favorites[model.id] != null)
                      //      IconButton(
                      //        icon: CircleAvatar(
                      //          backgroundColor:
                      //          AppCubit.get(context).favorites[model.id]==true
                      //              ? favColor
                      //              : defaultColor,
                      //          radius: 15.0,
                      //          child: Icon(
                      //            Icons.favorite_border,
                      //            color: Colors.white,
                      //            size: 17.0,
                      //          ),
                      //        ),
                      //   onPressed: () {
                      //       AppCubit.get(context).changeFavorite(model.id);
                      //   },
                      //
                      // ),

                      //     IconButton(
                      //   onPressed: () {
                      //     AppCubit.get(context).changeFavorite(model.id);
                      //   },
                      //   icon: CircleAvatar(
                      //     backgroundColor:
                      //     AppCubit.get(context).favorites[model.id]
                      //         ? favColor
                      //         : defaultColor,
                      //     radius: 15.0,
                      //     child: Icon(
                      //       Icons.favorite_border,
                      //       color: Colors.white,
                      //       size: 17.0,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
