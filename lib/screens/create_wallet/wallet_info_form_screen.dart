import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_bloc.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/models/args/create_or_import_args.dart';
import 'package:morph_wallet/services/navigation_service.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/form/form_widget.dart';
import 'package:morph_wallet/widgets/snakbar_widget.dart';

class WalletInfoFormScreen extends StatefulWidget {
  final CreateOrImportArgs args;

  const WalletInfoFormScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<WalletInfoFormScreen> createState() => _WalletInfoFormScreenState();
}

class _WalletInfoFormScreenState extends State<WalletInfoFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mnemonicCtl = TextEditingController();
  final TextEditingController _walletNameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final TextEditingController _confirmPasswordCtl = TextEditingController();
  final NavigationService _navService = locator<NavigationService>();
  final int _maxLength = 20;
  late CreateWalletBloc _createWalletBloc;
  late bool _isImport = widget.args.isImport;
  int _textLength = 0;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _createWalletBloc = context.read<CreateWalletBloc>();
  }

  @override
  void dispose() {
    _mnemonicCtl.dispose();
    _walletNameCtl.dispose();
    _passwordCtl.dispose();
    _confirmPasswordCtl.dispose();
    _createWalletBloc.close();
    super.dispose();
  }

  void _onConfirmButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _createWalletBloc.add(
        CreateWalletButtonPressed(
          _walletNameCtl.text.trim(),
          widget.args.mnemonic,
          _passwordCtl.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(_isImport ? 'Impor Dompet' : 'Informasi Dompet')),
      bottomNavigationBar: PrimaryButton(
        title: _isImport ? 'Mulai Impor' : 'Konfirmasi',
        onPressed: _onConfirmButtonPressed,
      ),
      body: BlocListener<CreateWalletBloc, CreateWalletState>(
        listener: (_, state) {
          if (state.status == CreateWalletStatus.success) {
            _navService.pushTo(MorphRoute.main);
          } else if (state.status == CreateWalletStatus.failure) {
            SnackBarWidget.show(context, message: '${state.message}');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CreateWalletBloc, CreateWalletState>(
            builder: (_, state) {
              return Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Visibility(
                      visible: _isImport ? false : true,
                      child: const Text(
                        'Berikan informasi berupa nama dompet dan kata sandi untuk keamanan tambahan.',
                      ),
                    ),
                    Visibility(
                      visible: _isImport ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: FormWidget(
                          hintText: 'Masukkan Mnemonic Anda',
                          hintStyle: Theme.of(context)
                              .inputDecorationTheme
                              .hintStyle
                              ?.copyWith(height: 2.8),
                          controller: _mnemonicCtl,
                          autofocus: true,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Mnemonic tidak boleh kosong!';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: _isImport ? 16.0 : 25.0),
                      child: FormWidget(
                        hintText: 'Nama Dompet',
                        controller: _walletNameCtl,
                        autofocus: true,
                        maxLength: _maxLength,
                        textCapitalization: TextCapitalization.sentences,
                        suffixText:
                            '${_textLength.toString()}/${_maxLength.toString()}',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        onChanged: (v) =>
                            setState(() => _textLength = v.length),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Nama dompet tidak boleh kosong!';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FormWidget(
                        hintText: 'Kata Sandi',
                        controller: _passwordCtl,
                        obscureText: _isVisible,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        onChanged: (v) {
                          setState(() => v = _passwordCtl.text);
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => _isVisible = !_isVisible);
                          },
                          child: Icon(
                            _isVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Kata sandi tidak boleh kosong!';
                          } else if (v.length < 6) {
                            return 'Kata sandi minimal berisi 6 karakter';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: FormWidget(
                        hintText: 'Konfirmasi Kata Sandi',
                        controller: _confirmPasswordCtl,
                        obscureText: _isVisible,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                        onChanged: (v) {
                          setState(() => v = _confirmPasswordCtl.text);
                        },
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => _isVisible = !_isVisible),
                          child: Icon(
                            _isVisible
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Konfirmasi kata sandi tidak boleh kosong!';
                          } else if (v != _passwordCtl.text) {
                            return 'Konfirmasi kata sandi tidak sama!';
                          }

                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
