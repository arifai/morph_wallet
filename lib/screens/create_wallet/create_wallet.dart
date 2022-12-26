import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/models/args/create_or_import_args.dart';
import 'package:morph_wallet/services/navigation_service.dart';
import 'package:morph_wallet/services/wallet_service.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';
import 'package:morph_wallet/widgets/commons/morph_icon.dart';
import 'package:morph_wallet/widgets/mnemonic/mnemonic_widget.dart';
import 'package:morph_wallet/widgets/commons/warning_widget.dart';

class CreateWallet extends StatelessWidget {
  const CreateWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> mnemonic = WalletService().generetaMnemonic();
    final NavigationService navService = locator<NavigationService>();

    onCopyButtonPressed(BuildContext context) {
      Clipboard.setData(ClipboardData(text: mnemonic.join(' ')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Dompet Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Tulis atau salin setiap kata di bawah ini secara berurutan dari kiri ke kanan dan simpan di tempat yang aman.',
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0),
                    child: WarningWidget(
                      text:
                          'Jangan pernah bocorkan mnemonic Anda kepada siapapun.',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                    child: MnemonicWidget(mnemonic: mnemonic),
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      MorphIcon.document_multiple,
                      color: MorphColor.whiteColor,
                    ),
                    label: Text(
                      'salin'.toUpperCase(),
                      style: const TextStyle(
                        color: MorphColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: onCopyButtonPressed(context),
                  )
                ],
              ),
            ),
            PrimaryButton(
              title: 'Selanjutnya',
              onPressed: () => navService.navigateTo(
                MorphRoute.walletInfoForm,
                arguments: CreateOrImportArgs(mnemonic: mnemonic.join(' ')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
