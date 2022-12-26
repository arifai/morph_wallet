import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/token/token_bloc.dart';
import 'package:morph_wallet/blocs/wallet_account/wallet_account_bloc.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/cores/size_config.dart';
import 'package:morph_wallet/models/token/token.dart';
import 'package:morph_wallet/utils/bytes.dart';
import 'package:morph_wallet/utils/string_extension.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/commons/loading.dart';
import 'package:morph_wallet/widgets/commons/modal_bottom_sheet.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';
import 'package:morph_wallet/widgets/commons/warning_widget.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TokenListScreen extends StatefulWidget {
  const TokenListScreen({Key? key}) : super(key: key);

  @override
  State<TokenListScreen> createState() => _TokenListScreenState();
}

class _TokenListScreenState extends State<TokenListScreen> {
  final ScrollController _scrollController = ScrollController();
  late List<Token> _tokens = [];
  // late double _totalEstimateAssets = 0;
  late TokenBloc _tokenBloc;
  late WalletAccountBloc _walletAccountBloc;
  String? _address;
  int? _balance;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _tokenBloc = context.read<TokenBloc>();
    _walletAccountBloc = context.read<WalletAccountBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final scrollPosition = _scrollController.position;

    if (scrollPosition.pixels == scrollPosition.maxScrollExtent) {
      debugPrint('Load more tokens...');
    }
  }

  void _onReceiveButtonPressed(String? address) async {
    modalBottomSheet(
      context: context,
      title: const WarningWidget(text: 'Hanya mendukung aset terkait SOL.'),
      heightFactor: 1,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MorphColor.whiteColor,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(14.0),
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: PrettyQr(
              data: '$address',
              size: 180.0,
              roundEdges: true,
              image: const AssetImage(MorphImage.solanaGreyScale),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              '$address',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      bottomContent: PrimaryButton(
        title: 'Salin Alamat',
        onPressed: () => Clipboard.setData(ClipboardData(text: '$address')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: BlocBuilder<WalletAccountBloc, WalletAccountState>(
        bloc: _walletAccountBloc,
        builder: (_, state) {
          if (state.status == WalletAccountStatus.loading) {
            return const Loading();
          } else if (state.status == WalletAccountStatus.loaded) {
            _address = state.address;
            _balance = state.balance;
          }

          if (_balance == null) {
            return const Loading();
          }

          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'ESTIMASI ASET',
                style: TextStyle(
                  fontSize: 15.0,
                  color: MorphColor.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  '$_balance'.toSol(),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const _MenuButton(title: 'Kirim', onPressed: null),
                    _MenuButton(
                      title: 'Terima',
                      onPressed: () => _onReceiveButtonPressed(_address),
                    ),
                  ],
                ),
              ),
              const Divider(),
              BlocBuilder<TokenBloc, TokenState>(
                builder: (_, state) {
                  if (state.status == TokenStatus.loading) {
                    return const Loading();
                  } else if (state.status == TokenStatus.loaded) {
                    _tokens = state.tokens;
                  }

                  if (_tokens.isEmpty) {
                    return const Loading();
                  }

                  // Calculate estimate total assets (IDR)
                  // _totalEstimateAssets = _tokens
                  //     .map((e) => e.toIDRBalance)
                  //     .reduce((a, b) => a + b);

                  return Flexible(
                    child: RefreshIndicator(
                      color: MorphColor.primaryColor,
                      displacement: 10.0,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2))
                            .then((_) => _tokenBloc.add(LoadListToken()));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _tokens.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          var token = _tokens[index];

                          return ListTile(
                            key: ValueKey('__${token.ticker}_${index}__'),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: FadeInImage.memoryNetwork(
                                placeholder: bytes,
                                image: token.imageUrl,
                                fit: BoxFit.cover,
                                height: 40.0,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  token.ticker,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  token.balance.toString(),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: '${token.price}'.toIdr(),
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      color: MorphColor.greyColor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '\u{2002}\u{2002}${token.priceChanges}',
                                        style: const TextStyle(
                                          color: MorphColor.errorColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${token.toIDRBalance}'.toIdr(),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: MorphColor.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const _MenuButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      title: title,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            fixedSize: MaterialStateProperty.all(
              Size(
                SizeConfig.blockSizeVertical * 17,
                SizeConfig.blockSizeHorizontal * 10,
              ),
            ),
          ),
      onPressed: onPressed,
    );
  }
}
