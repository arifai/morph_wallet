import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_event.dart';
import 'package:morph_wallet/blocs/nft/nft_state.dart';
import 'package:morph_wallet/models/nft/nft.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/widgets/collectibles/collectible_image_widget.dart';
import 'package:morph_wallet/widgets/commons/loading.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class CollectibleListScreen extends StatefulWidget {
  const CollectibleListScreen({Key? key}) : super(key: key);

  @override
  State<CollectibleListScreen> createState() => _CollectibleListScreenState();
}

class _CollectibleListScreenState extends State<CollectibleListScreen> {
  late NftBloc _nftBloc;
  late List<Nft> _nfts = [];

  @override
  void initState() {
    super.initState();
    _nftBloc = context.read<NftBloc>();
  }

  @override
  void dispose() {
    _nftBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NftBloc, NftState>(
      builder: (_, state) {
        if (state is NftListLoading) {
          return const Loading();
        } else if (state is NftListLoaded) {
          _nfts = state.nfts;
        }

        if (_nfts.isEmpty) {
          return const EmptyScreen(text: 'No NFTs');
        }

        return RefreshIndicator(
          color: MorphColor.primaryColor,
          displacement: 10.0,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2)).then((_) {
              _nftBloc.add(LoadListNft());
            });
          },
          child: GridView.builder(
            itemCount: _nfts.length,
            padding: const EdgeInsets.all(20.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (_, idx) => Stack(
              children: [
                CollectibleImageWidget(imgUrl: _nfts[idx].imgUrl),
                Positioned(
                  height: 30.0,
                  bottom: 5.0,
                  right: 13,
                  left: 13,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: MorphColor.secondaryDarkColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              _nfts[idx].name,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Text(
                              _nfts[idx].count.toString(),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: MorphColor.greyColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
