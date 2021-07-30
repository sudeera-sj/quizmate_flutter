import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quizmate_flutter/ui/components/rounded_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// This screen displays information about this app.
/// Includes details about the technologies and concepts used to develop the application,
/// as well as information about the license credits.
class AboutApp extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AboutApp._());

  const AboutApp._({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'About app',
                style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              const _Overview(),
              const SizedBox(height: 24),
              const _TopicsAndConcepts(),
              const SizedBox(height: 24),
              const _ToolsResourcesAndLibraries(),
              const SizedBox(height: 24),
              const _Credits(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/app_icon/icon-256.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'QuizMate',
              style: theme.textTheme.headline4,
            ),
            const SizedBox(height: 4),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.version,
                    style: theme.textTheme.caption,
                  );
                } else {
                  return SizedBox(height: 4);
                }
              },
            ),
            const SizedBox(height: 16),
            Text(
              'A simple quiz app demonstrating the use of core concepts and'
              ' utilities in React Native development',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText2,
            ),
            const SizedBox(height: 24),
            RoundedButton.filled(
              label: 'View source',
              onPressed: () async => await launch('https://github.com/SudeeraSJ/quizmate_flutter'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicsAndConcepts extends StatelessWidget {
  const _TopicsAndConcepts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topics covered by the project',
              style: theme.textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _createListItem(
                  title: 'UI design with material components',
                  subtitle: 'stateless and stateful widgets',
                ),
                _createListItem(
                  title: 'Application theming',
                  subtitle: 'light/dark color themes, custom fonts',
                ),
                _createListItem(
                  title: 'State management',
                  subtitle: 'local and global state',
                ),
                _createListItem(
                  title: 'Navigation',
                  subtitle: 'routing with Flutter navigator',
                ),
                _createListItem(
                  title: 'API access',
                  subtitle: 'http requests and responses',
                ),
                _createListItem(
                  title: 'Dart extensions',
                  subtitle: 'adding functionality on existing types',
                ),
                _createListItem(
                  title: 'Object immutability',
                  subtitle: 'thread-safe, unchanging objects',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile _createListItem({required String title, required String subtitle}) {
    return ListTile(
      leading: const Icon(Icons.check_circle_outline_rounded),
      horizontalTitleGap: 0,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

class _ToolsResourcesAndLibraries extends StatelessWidget {
  const _ToolsResourcesAndLibraries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tools and resources',
              style: theme.textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _createListItem(
                  title: 'Android studio',
                  url: 'https://developer.android.com/studio',
                ),
                _createListItem(
                  title: 'BLoC and Flutter BLoC',
                  url: 'https://bloclibrary.dev/#/',
                ),
                _createListItem(
                  title: 'Dio HTTP client',
                  url: 'https://pub.dev/packages/dio',
                ),
                _createListItem(
                  title: 'Google fonts',
                  url: 'https://pub.dev/packages/google_fonts',
                ),
                _createListItem(
                  title: 'Syncfusion Flutter widgets',
                  url: 'https://github.com/syncfusion/flutter-widgets',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile _createListItem({required String title, required String url}) {
    return ListTile(
      leading: const Icon(Icons.library_books_rounded),
      horizontalTitleGap: 0,
      dense: true,
      title: Text(title),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      minVerticalPadding: 0,
      onTap: () async => await launch(url),
      trailing: const Icon(Icons.open_in_browser_rounded),
    );
  }
}

class _Credits extends StatelessWidget {
  const _Credits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credits',
              style: theme.textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _createListItem(
                  icon: Icons.code_rounded,
                  title: 'Application developed by',
                  subtitle: 'Sudeera Sandaruwan Jayasinghe - Colombo, Sri Lanka',
                  url: 'https://www.linkedin.com/in/sudeerasandaruwan/',
                ),
                _createListItem(
                  icon: Icons.format_paint_rounded,
                  title: 'Application icon',
                  subtitle: 'Designed by Freepik from flaticon.com',
                  url: 'https://www.flaticon.com/authors/freepik',
                ),
                _createListItem(
                  icon: Icons.format_paint_rounded,
                  title: 'Application cover image',
                  subtitle: 'Designed by dashu83 from freepik.com',
                  url: 'https://www.freepik.com/dashu83',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile _createListItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String url,
  }) {
    return ListTile(
      leading: Icon(icon),
      horizontalTitleGap: 0,
      dense: true,
      title: Text(title),
      subtitle: Text(subtitle),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      minVerticalPadding: 0,
      onTap: () async => await launch(url),
      trailing: const Icon(Icons.open_in_browser_rounded),
    );
  }
}
