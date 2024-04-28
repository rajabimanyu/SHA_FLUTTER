import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BuildContext? showLoaderDialog(BuildContext context){
  BuildContext? dialogContext;
  AlertDialog alert=AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 20),child:Text("Processing..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
    dialogContext = context;
      return alert;
    },
  );
  return dialogContext;
}

isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;