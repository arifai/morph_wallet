import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_bloc.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_event.dart';
import 'package:morph_wallet/blocs/create_wallet/create_wallet_state.dart';
import 'package:morph_wallet/cores/locator.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/models/wallet_account/wallet_account.dart';
import 'package:morph_wallet/services/navigation_service.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/form/form_widget.dart';

class WalletInfoFormScreen extends StatefulWidget {
  final String mnemonic;

  const WalletInfoFormScreen({Key? key, required this.mnemonic})
      : super(key: key);

  @override
  State<WalletInfoFormScreen> createState() => _WalletInfoFormScreenState();
}

class _WalletInfoFormScreenState extends State<WalletInfoFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _walletNameCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();
  final TextEditingController _confirmPasswordCtl = TextEditingController();
  final NavigationService _navService = locator<NavigationService>();
  final int _maxLength = 20;
  int _textLength = 0;
  bool _isVisible = true;

  @override
  void dispose() {
    _walletNameCtl.dispose();
    _passwordCtl.dispose();
    _confirmPasswordCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Dompet'),
      ),
      body: BlocListener<CreateWalletBloc, CreateWalletState>(
        listener: (_, state) {
          if (state is CreateWalletSuccess) {
            _navService.pushTo(MorphRoute.main);
          } else if (state is CreateWalletFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<CreateWalletBloc, CreateWalletState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const Text(
                              'Berikan informasi berupa nama dompet dan kata sandi untuk keamanan tambahan.'),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
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
                              onChanged: (value) {
                                setState(() => _textLength = value.length);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
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
                              onChanged: (value) {
                                setState(() => value = _passwordCtl.text);
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kata sandi tidak boleh kosong!';
                                } else if (value.length < 6) {
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
                              onChanged: (value) {
                                setState(
                                    () => value = _confirmPasswordCtl.text);
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi kata sandi tidak boleh kosong!';
                                } else if (value != _passwordCtl.text) {
                                  return 'Konfirmasi kata sandi tidak sama!';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PrimaryButton(
                    title: 'Konfirmasi',
                    onPressed: state is! CreateWalletLoading
                        ? _onConfirmButtonPressed
                        : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onConfirmButtonPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<CreateWalletBloc>().add(
            CreateWalletButtonPressed(
              WalletAccount(
                _walletNameCtl.text.trim(),
                widget.mnemonic,
                _passwordCtl.text,
              ),
            ),
          );
    }
  }
}
