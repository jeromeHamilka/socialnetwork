import 'package:flutter/material.dart';
import 'package:socialnetwork/util/images.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () {},
          child: Container(
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
                      children: const [
                        Text("Se connecter"),
                        Text("Creer un compte"),
                        // logCard(true),
                        // logCard(false),
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
}
