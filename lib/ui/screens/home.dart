import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizmate_flutter/bloc/category/category_bloc.dart';
import 'package:quizmate_flutter/bloc/category/category_state.dart';
import 'package:quizmate_flutter/models/util/task_progress.dart';
import 'package:quizmate_flutter/ui/components/rounded_button.dart';
import 'package:quizmate_flutter/ui/screens/quiz_creator.dart';

/// Created by Sudeera Sandaruwan
class Home extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const Home());

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
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
                    image: const DecorationImage(
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
                                  icon: const Icon(Icons.info),
                                  iconSize: 32,
                                  padding: const EdgeInsets.only(top: 16, right: 16),
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
                              padding: const EdgeInsets.symmetric(vertical: 48),
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
                  margin: const EdgeInsets.only(top: 24),
                  child: const _FooterContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) {
        return previous.progress != TaskProgress.success &&
            current.progress == TaskProgress.success;
      },
      builder: (context, state) {
        if (state.progress == TaskProgress.success) {
          return RoundedButton.filled(
            label: "Start a new Quiz",
            onPressed: () {
              Navigator.of(context).push(QuizCreator.route());
            },
          );
        } else {
          return Column(
            children: [
              const CircularProgressIndicator(
                value: null,
              ),
              const SizedBox(height: 16),
              Text(
                'Setting things up',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          );
        }
      },
    );
  }
}
