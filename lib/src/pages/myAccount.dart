import 'dart:math';

import 'package:FlexPay/src/model/accountItemList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  double _progressSlideSheet = 0;
  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Feather.grid),
                Text(
                  'Minha Conta',
                  style: GoogleFonts.kodchasan().copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 21),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/vetores-gratis/perfil-de-avatar-de-homem-no-icone-redondo_24640-14044.jpg'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 30, right: 30),
            child: Column(
              children: <Widget>[
                AnimatedContainer(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(0, 2))
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigoAccent,
                          Colors.indigo,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  duration: Duration(milliseconds: 500),
                  height: _progressSlideSheet == 0
                      ? 180
                      : 180 - _progressSlideSheet * 65,
                  curve: Curves.elasticOut,
                ),
                SizedBox(
                  height: 20,
                ),
                _progressSlideSheet < 1
                    ? AnimatedOpacity(
                        opacity: 1 - _progressSlideSheet,
                        duration: Duration(milliseconds: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Feather.chevron_up,
                              color: Colors.grey,
                              size: 12,
                            ),
                            Text('Arraste para cima para esconder o número',
                                style: GoogleFonts.lato().copyWith(
                                    color: Colors.grey[400], fontSize: 12)),
                          ],
                        ),
                      )
                    : AnimatedOpacity(
                        opacity: _progressSlideSheet,
                        duration: Duration(milliseconds: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Feather.chevron_down,
                              color: Colors.grey,
                              size: 12,
                            ),
                            Text('Arraste para baixo para mostrar o número',
                                style: GoogleFonts.lato().copyWith(
                                    color: Colors.grey[400], fontSize: 12)),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Transações',
                    style: GoogleFonts.kodchasan().copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 21),
                  ),
                ),

                Align(
                  child: ProgressButton.icon(
                      radius: 100.0,
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text: "Atualizar",
                            icon: Icon(Icons.refresh, color: Colors.white),
                            color: Colors.indigo.shade500),
                        ButtonState.loading: IconedButton(
                            text: "Loading", color: Colors.indigo.shade700),
                        ButtonState.fail: IconedButton(
                            text: "Failed",
                            icon: Icon(Icons.cancel, color: Colors.white),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400)
                      },
                      onPressed: onPressedIconWithText,
                      state: stateTextWithIcon),
                )
              ],
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            right: 50,
            child: AnimatedPadding(
              padding: EdgeInsets.only(top: 130 + _progressSlideSheet * 21),
              duration: Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              child: Image.network(
                'https://www.zzlocal.com/images/visa-logo-black-and-white.png',
                height: 80,
                width: 80,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            left: 50,
            child: AnimatedOpacity(
              opacity: 1 - _progressSlideSheet,
              duration: Duration(milliseconds: 50),
              child: AnimatedPadding(
                padding: EdgeInsets.only(top: 150),
                duration: Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                child: Image.network(
                  'https://img.icons8.com/cotton/2x/sim-card-chip.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            left: 50,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 50),
              opacity: 1 - _progressSlideSheet,
              child: AnimatedPadding(
                padding: EdgeInsets.only(top: 220),
                duration: Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                child: Text(
                  '1535    1518    1996    1885',
                  style: GoogleFonts.lato().copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            left: 50,
            child: AnimatedPadding(
              padding: EdgeInsets.only(top: 255 - _progressSlideSheet * 80),
              duration: Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              child: Text(
                ' 245,00',
                style: GoogleFonts.lato().copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 28),
              ),
            ),
          ),
          SlidingSheet(
            listener: (state) {
              setState(() {
                _progressSlideSheet = state.progress;
              });
            },
            color: Colors.grey[800],
            elevation: 10,
            cornerRadius: 20,
            closeOnBackdropTap: true,
            snapSpec: const SnapSpec(
              snappings: [
                0.40,
                0.52,
              ],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                color: Colors.grey[800],
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          height: 5,
                          width: 60,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            AccountItemList(
                              icone: Icon(
                                Feather.shopping_bag,
                                color: Colors.white,
                              ),
                              texto: 'Compras',
                              preco: '240,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.headphones,
                                color: Colors.white,
                              ),
                              texto: 'Entretenimento',
                              preco: '100,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.alert_triangle,
                                color: Colors.white,
                              ),
                              texto: 'Manutenção',
                              preco: '500,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.pie_chart,
                                color: Colors.white,
                              ),
                              texto: 'Alimentação',
                              preco: '300,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.shopping_bag,
                                color: Colors.white,
                              ),
                              texto: 'Compras',
                              preco: '240,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.headphones,
                                color: Colors.white,
                              ),
                              texto: 'Entretenimento',
                              preco: '100,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.alert_triangle,
                                color: Colors.white,
                              ),
                              texto: 'Manutenção',
                              preco: '500,00',
                              qtdTransacoes: '1',
                            ),
                            AccountItemList(
                              icone: Icon(
                                Feather.pie_chart,
                                color: Colors.white,
                              ),
                              texto: 'Alimentação',
                              preco: '300,00',
                              qtdTransacoes: '1',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
