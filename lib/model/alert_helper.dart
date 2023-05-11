import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertHelper {

  Future<void> error(BuildContext context, String error) async {
    bool isiOS = (Theme
        .of(context)
        .platform == TargetPlatform.iOS);
    const title = Text("Erreur");
    final explanation = Text(error);
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (isiOS)
              ? CupertinoAlertDialog(
            title: title, content: explanation, actions: [close(ctx, "OK")],)
              : AlertDialog(
            title: title, content: explanation, actions: [close(ctx, "OK")],);
        }
    );
  }

  TextButton close(BuildContext context, String string) {
    return TextButton(
        onPressed: (() => Navigator.pop(context)),
        child: Text(string)
    );
  }

}