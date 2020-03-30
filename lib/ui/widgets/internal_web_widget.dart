import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:redditapp/blocs/authentication/bloc_authentication.dart';
import 'package:redditapp/blocs/blocs/user_profile_bloc.dart';
import 'package:redditapp/blocs/events/user_profile_event.dart';
import 'package:redditapp/reddit/reddit_api.dart';

import '../../config.dart';

class InternalWebView extends StatefulWidget {
  final String url;

  InternalWebView({
    @required this.url,
  });

  @override
  _InternalWebViewState createState() => _InternalWebViewState();
}

class _InternalWebViewState extends State<InternalWebView> {
  final FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (url.startsWith(Config.redirectUri)) {
        Uri parsed = Uri.parse(url);
        BlocProvider.of<AuthenticationBloc>(context).add(AuthenticateUser(
          code: parsed.queryParameters["code"],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return WebviewScaffold(
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitWave(
                      color: Colors.black,
                      size: 42.0,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "Redirecting to external Reddit login webpage for security reasons...",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(StopAuthentication());
                  //flutterWebViewPlugin.close();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                flutterWebViewPlugin.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                flutterWebViewPlugin.goForward();
                },
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                flutterWebViewPlugin.reload();
                },
              ),
            ],
            ),
          ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebViewPlugin.close();
  }
}
