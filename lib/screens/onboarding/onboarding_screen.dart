import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/services/navigation_service.dart';
import 'package:morph_wallet/services/wallet_service.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/buttons/secondary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService _navService = locator<NavigationService>();
    List<String> mnemonic = WalletService().generetaMnemonic();

    void _onCreateButtonPressed() {
      _navService.navigateTo(MorphRoute.createWallet, arguments: mnemonic);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Image.asset(
                      MorphImage.pattern,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 30.0,
                        right: 30.0,
                        left: 30.0,
                        bottom: 5.0,
                      ),
                      child: Text(
                        'Mulai Dengan Morph Wallet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        right: 30.0,
                        left: 30.0,
                      ),
                      child: Text(
                        'Buat baru atau impor dompet kripto Anda dan mulai amankan aset Anda',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PrimaryButton(
                      title: 'Buat Dompet Baru',
                      onPressed: _onCreateButtonPressed,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: SecondaryButton(
                      title: 'Impor Dompet Anda',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
