import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/size_config.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/mnemonic_widget.dart';
import 'package:morph_wallet/widgets/warning_widget.dart';

class CreateWallet extends StatelessWidget {
  final String mnemonic;

  const CreateWallet({Key? key, required this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                    child: MnemonicBox(mnemonic: mnemonic.split(' ')),
                  ),
                  TextButton.icon(
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: MorphColor.whiteColor,
                    ),
                    label: Text(
                      'salin'.toUpperCase(),
                      style: const TextStyle(
                        color: MorphColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _onCopyButtonPressed(context),
                  )
                ],
              ),
            ),
            PrimaryButton(
              title: 'Selanjutnya',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  _onCopyButtonPressed(BuildContext context) {
    Clipboard.setData(ClipboardData(text: mnemonic));
  }
}

class MnemonicBox extends StatelessWidget {
  final List<String> mnemonic;
  const MnemonicBox({Key? key, required this.mnemonic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: Add gradient outline border. See design on Figma.
    return GridView.builder(
      shrinkWrap: true,
      itemCount: mnemonic.length,
      // padding: const EdgeInsets.all(5.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 50,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
      itemBuilder: (_, idx) => Container(
        color: MorphColor.darkColor,
        padding: const EdgeInsets.all(4.0),
        child: MnemonicWidget(mnemonic: mnemonic[idx]),
      ),
    );
  }
}
