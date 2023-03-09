import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiKey = "Your_api_key";
  final String apiSecretKey = 'Your_secret_api_key';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('twitter login sample'),
      ),
      body: Center(
        child: ListView(
          children: [
            Center(
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(160, 48)),
                ),
                onPressed: () async {
                  await login();
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Use Twitter API v1.1
  Future login() async {
    final twitterLogin = TwitterLogin(
      /// Consumer API keys
      apiKey: apiKey,

      /// Consumer API Secret keys
      apiSecretKey: apiSecretKey,

      /// Registered Callback URLs in TwitterApp
      /// Android is a deeplink
      /// iOS is a URLScheme
      redirectURI: 'example://twitter_auth',
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        // success
        print('====== Login success ======');
        print(authResult.authToken);
        print(authResult.authTokenSecret);
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }
}
