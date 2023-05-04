import 'package:flutter/material.dart';
import 'package:socialnetwork/util/images.dart';

import '../custom_widget/my_gradient.dart';
import '../custom_widget/my_textField.dart';
import '../custom_widget/padding_with.dart';
import '../model/my_painter.dart';

class AuthController extends StatefulWidget {
  const AuthController({Key? key}) : super(key: key);

  @override
  State<AuthController> createState() => _AuthControllerState();
}

class _AuthControllerState extends State<AuthController> {
  late PageController _pageController;
  late TextEditingController _mail;
  late TextEditingController _password;
  late TextEditingController _name;
  late TextEditingController _surname;

  @override
  void initState() {
    _pageController = PageController();
    _mail = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _surname = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mail.dispose();
    _password.dispose();
    _name.dispose();
    _surname.dispose();
    super.dispose();
  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {
            hideKeyboard();
          },
          child: Container(
            //decoration: MyGradient(startColor: ColorTheme().pointer(), endColor: ColorTheme().base(), horizontal: false),
            decoration: MyGradient(
                startColor: Colors.white,
                endColor: Colors.red,
                horizontal: false),
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height > 700)
                ? MediaQuery.of(context).size.height
                : 700,
            child: SafeArea(
              child: Column(
                children: [
                  Image.asset(
                    logoImage,
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  logOrCreateButtons(),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        logCard(true),
                        logCard(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logOrCreateButtons() {
    return Container(
      // decoration: MyGradient(
      //     horizontal: true,
      //     startColor: ColorTheme().base(),
      //     endColor: ColorTheme().pointer(),
      //     radius: 25
      // ),
      width: 300,
      height: 50,
      child: CustomPaint(
        painter: MyPainter(pageController: _pageController),
        child: Row(
          children: [
            btn("Se Connecter"),
            btn("Créer un compte"),
          ],
        ),
      ),
    );
  }

  Expanded btn(String name) {
    return Expanded(
      child: TextButton(
        child: Text(name),
        onPressed: () {
          int page = (_pageController.page == 0.0) ? 1 : 0;
          _pageController.animateToPage(page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        },
      ),
    );
  }

  Widget logCard(bool userExists) {
    List<Widget> list = [];
    if (!userExists) {
      list.add(MyTextField(
        controller: _surname,
        hint: "Entrez votre prénom",
      ));
      list.add(MyTextField(
        controller: _name,
        hint: "Entrez votre nom",
      ));
    }
    list.add(MyTextField(
      controller: _mail,
      hint: "Adresse mail",
    ));
    list.add(MyTextField(
      controller: _password,
      hint: "Mot de passe",
      obscure: true,
    ));

    return PaddingWith(
      child: Center(
        child: Card(
          elevation: 7.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
        ),
      ),
    );
  }
}
