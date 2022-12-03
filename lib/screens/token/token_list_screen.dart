import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/token/token_bloc.dart';
import 'package:morph_wallet/blocs/token/token_event.dart';
import 'package:morph_wallet/blocs/token/token_state.dart';
import 'package:morph_wallet/cores/size_config.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/utils/bytes.dart';
import 'package:morph_wallet/utils/string_extension.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';
import 'package:morph_wallet/widgets/commons/loading.dart';
import 'package:morph_wallet/widgets/commons/modal_bottom_sheet.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';
import 'package:morph_wallet/widgets/commons/warning_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TokenListScreen extends StatefulWidget {
  const TokenListScreen({Key? key}) : super(key: key);

  @override
  State<TokenListScreen> createState() => _TokenListScreenState();
}

class _TokenListScreenState extends State<TokenListScreen> {
  final ScrollController _scrollController = ScrollController();
  late double _totalEstimateAssets = 0;
  late TokenBloc _tokenBloc;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _tokenBloc = context.read<TokenBloc>();
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
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
              '$_totalEstimateAssets'.toIdr(),
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
                PrimaryButton(
                  title: 'Kirim',
                  borderRadius: 25.0,
                  fixedSize: MaterialStateProperty.all(
                    Size(
                      SizeConfig.blockSizeVertical * 17,
                      SizeConfig.blockSizeHorizontal * 10,
                    ),
                  ),
                  onPressed: () {},
                ),
                PrimaryButton(
                  title: 'Terima',
                  borderRadius: 25.0,
                  fixedSize: MaterialStateProperty.all(
                    Size(
                      SizeConfig.blockSizeVertical * 17,
                      SizeConfig.blockSizeHorizontal * 10,
                    ),
                  ),
                  onPressed: _onReceiveButtonPressed,
                ),
              ],
            ),
          ),
          const Divider(),
          BlocBuilder<TokenBloc, TokenState>(
            builder: (_, state) {
              if (state is TokenListLoading) {
                return const Loading();
              } else if (state is TokenListLoaded) {
                final tokens = state.tokens;

                // Calculate estimate total assets (IDR)
                _totalEstimateAssets =
                    tokens.map((e) => e.toIDRBalance).reduce((a, b) => a + b);

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
                      itemCount: tokens.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        var token = tokens[index];

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
              } else {
                return const EmptyScreen(text: 'Unknown State');
              }
            },
          ),
        ],
      ),
    );
  }

  void _onReceiveButtonPressed() {
    const String address = 'widget.walletAccount.address';

    modalBottomSheet(
      context: context,
      title: const WarningWidget(text: 'Hanya mendukung aset terkait SOL.'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
            child: QrImage(
              data: address,
              size: 170.0,
              semanticsLabel: address,
              backgroundColor: MorphColor.whiteColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              address,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      bottomContent: PrimaryButton(
        title: 'Salin Alamat',
        onPressed: () => Clipboard.setData(const ClipboardData(text: address)),
      ),
    );
  }
}