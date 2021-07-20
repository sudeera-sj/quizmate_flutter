import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizmate_flutter/ui/components/rounded_button.dart';

/// Created by Sudeera Sandaruwan
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      primary: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 48, horizontal: 24),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      image: AssetImage("assets/images/home_cover.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.info),
                                  iconSize: 32,
                                  padding: EdgeInsets.only(top: 16, right: 16),
                                  splashRadius: 8,
                                  color: Colors.white,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 48),
                              child: Image.asset(
                                'assets/app_icon/icon-512.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'QuizMate',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headline3!.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  child: RoundedButton.filled("Start a new Quiz", () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
