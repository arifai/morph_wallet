import 'package:flutter/material.dart';
import 'package:morph_wallet/cores/morph_core.dart';
import 'package:morph_wallet/models/token/token.dart';
import 'package:morph_wallet/size_config.dart';
import 'package:morph_wallet/utils/string_extension.dart';
import 'package:morph_wallet/widgets/buttons/primary_button.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController _scrollCtl = ScrollController();
  final List<Token> _tokens = [
    Token(
      'https://s2.coinmarketcap.com/static/img/coins/200x200/5426.png',
      '-2.7%',
      'SOL',
      1409820.19,
      1.65,
      2326977.60,
    ),
    Token(
      'https://pbs.twimg.com/profile_images/1477759103250358274/Fhq3wD1d_400x400.jpg',
      '-6.63%',
      'SAMO',
      279.76,
      578,
      156405.77,
    ),
  ];

  @override
  void initState() {
    _scrollCtl.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollCtl.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final _scrollPosition = _scrollCtl.position;

    if (_scrollPosition.pixels == _scrollPosition.maxScrollExtent) {
      debugPrint('Load more tokens...');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              '2483383.37'.toIdr(),
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 10.0,
              right: 10.0,
            ),
            // FIXME: [ClampingScrollPhysics] not working for [ListView]
            child: ListView.builder(
              controller: _scrollCtl,
              itemCount: _tokens.length,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                var token = _tokens[index];

                return ListTile(
                  key: ValueKey('__${token.ticker}_${index}__'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(token.imageUrl),
                    radius: 20.0,
                    backgroundColor: MorphColor.greyColor,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        token.ticker,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Text(
                          token.balance.toString(),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: RichText(
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
                                // I don't know 'white space' unicode in Flutter
                                text: '   ${token.priceChanges}',
                                style: const TextStyle(
                                    color: MorphColor.errorColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${token.toIDRBalance}'.toIdr(),
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: MorphColor.greyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
