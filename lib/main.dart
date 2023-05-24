import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

void main() {
  runApp(const MaterialApp(home: WalletConnectExample()));
}

class WalletConnectExample extends StatefulWidget {
  const WalletConnectExample({super.key});

  @override
  State<WalletConnectExample> createState() => _WalletConnectExampleState();
}

class _WalletConnectExampleState extends State<WalletConnectExample> {
  final connector = WalletConnect(
    bridge: 'https://bridge.walletconnect.org',
    clientMeta: const PeerMeta(
      name: 'WalletConnect',
      description: 'WalletConnect Developer App',
      url: 'https://walletconnect.org',
      icons: [
        'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
      ],
    ),
  );
  String _message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletConnect Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(_message),
          ),
          Center(
            child: MaterialButton(
              minWidth: 200,
              color: const Color.fromRGBO(117, 59, 189, 1),
              onPressed: () async {
                final session = await connector.connect(
                  chainId: 44787 /* 4 */,
                  onDisplayUri: (uri) async {
                    await launchUrlString('metamask://wc?uri=$uri',
                        mode: LaunchMode.externalApplication);
                    setState(
                      () {
                        _message = 'Uri to Launch --> metamask://wc?uri=$uri';
                      },
                    );
                  },
                );
              },
              child: const Text(
                'Launch Incorrect DeepLink',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            minWidth: 200,
            color: const Color.fromRGBO(117, 59, 189, 1),
            onPressed: () async {
              final session = await connector.connect(
                chainId: 44787 /* 4 */,
                onDisplayUri: (uri) async {
                  await launchUrlString(uri,
                      mode: LaunchMode.externalApplication);
                  setState(
                    () {
                      _message = 'Uri to launch --> $uri';
                    },
                  );
                },
              );
            },
            child: const Text('Launch Correct DeepLink',
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
