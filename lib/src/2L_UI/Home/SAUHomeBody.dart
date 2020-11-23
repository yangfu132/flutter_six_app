import 'package:flutter/material.dart';
import 'dart:io';
import '../../1L_Context/SACContext.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/src/foundation/constants.dart';
import 'AnimationDiceWidget.dart';
import '../EasyExpertResult/SAUEasyExpertResultRoute.dart';
import '../../3L_Business/Easy/SABEasyDigitModel.dart';

class SAUHomeBody extends StatefulWidget {
  SAUHomeBody({Key key, this.title}) : super(key: key);
  final String title;
  @override
  SAUHomeBodyState createState() {
    return SAUHomeBodyState();
  }
}

class SAUHomeBodyState extends State<SAUHomeBody> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  AnimationDiceWidget animationWidget;
  bool _bAnimation = false;
  @override
  void initState() {
    super.initState();

    // if (kIsWeb) {
    //   // Calls to Platform.isIOS fails on web
    //   return;
    // }

    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }

    animationWidget = AnimationDiceWidget(() {});
  }

  @override
  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = 80.0;
    double widthBg =
        SACContext.screenHeight(context) > SACContext.screenWidth(context)
            ? SACContext.screenWidth(context)
            : SACContext.screenHeight(context);
    Image imageWan = Image.asset(
      'images/shangpingwan@2x.png',
      width: widthBg,
      height: widthBg,
      fit: BoxFit.fill,
    );

    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/8466654.jpg',
            width: SACContext.screenWidth(context),
            height: SACContext.screenHeight(context),
            fit: BoxFit.fill,
          ),
          Positioned(
            child: imageWan,
            top: 40,
          ),
          Positioned(
            top: 380,
            left: 230,
            child: Visibility(
              child: Image.asset('images/1@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            top: 300,
            left: 400,
            child: Visibility(
              child: Image.asset('images/2@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            top: 450,
            left: 450,
            child: Visibility(
              child: Image.asset('images/4@2x.png'),
              visible: !_bAnimation,
            ),
          ),
          Positioned(
            child: Visibility(
              child: AnimationDiceWidget(() {
                _bAnimation = false;
                setState(() {});
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  SABEasyDigitModel outEasyModel =
                      SABEasyDigitModel('测试', '子孙');
                  outEasyModel.generateEasyArray();
                  return SAUEasyExpertResultRoute(outEasyModel);
                }));
              }),
              visible: _bAnimation,
            ),
            top: 50,
            bottom: 50,
            left: 0,
            right: 50,
          ),
          Positioned(
            bottom: 50,
            left: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: FlatButton(
              child: Text(
                '开始',
                style: TextStyle(
                  color: Color(0xFFE5CC69),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                _bAnimation = true;
                setState(() {});
                audioCache.play('glass.wav', mode: PlayerMode.LOW_LATENCY);
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: (SACContext.screenWidth(context) / 2 - buttonWidth) / 2,
            child: FlatButton(
                child: Text(
                  '用户',
                  style: TextStyle(
                    color: Color(0xFFE5CC69),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnimationRoute();
                  }));
                }),
          ),
        ],
      ),
    );
  }
}
