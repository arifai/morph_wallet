import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_bloc.dart';
import 'package:morph_wallet/blocs/nft/nft_event.dart';
import 'package:morph_wallet/blocs/nft/nft_state.dart';
import 'package:morph_wallet/screens/empty/empty_screen.dart';
import 'package:morph_wallet/widgets/commons/loading.dart';
import 'package:morph_wallet/widgets/commons/morph_color.dart';

class CollectibleListScreen extends StatefulWidget {
  const CollectibleListScreen({Key? key}) : super(key: key);

  @override
  State<CollectibleListScreen> createState() => _CollectibleListScreenState();
}

class _CollectibleListScreenState extends State<CollectibleListScreen> {
  @override
  Widget build(BuildContext context) {
    final _nftBloc = BlocProvider.of<NftBloc>(context);

    return BlocBuilder<NftBloc, NftState>(builder: (_, state) {
      if (state is NftListLoading) {
        return const Loading();
      } else if (state is NftListLoaded) {
        final nfts = state.nfts;

        return RefreshIndicator(
          color: MorphColor.primaryColor,
          displacement: 10.0,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2)).then((_) {
              _nftBloc.add(LoadListNft());
            });
          },
          child: GridView.builder(
            itemCount: nfts.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (_, idx) => Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Text('...'),
                    imageUrl: nfts[idx].imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
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
                              nfts[idx].name,
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
                              nfts[idx].count.toString(),
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
      } else {
        return const EmptyScreen(text: 'Unknown State');
      }
    });
  }
}
