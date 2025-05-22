import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaruantAppBar extends StatelessWidget {
  const RestaruantAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'images/Header-image.png',
          fit: BoxFit.cover
          ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: CircleAvatar(
        backgroundColor: Colors.white,
        child: SvgPicture.network("https://www.svgrepo.com/show/18507/back-button.svg"),
        ),
      ),
      actions: [
        CircleAvatar(
        backgroundColor: Colors.white,
        child: SvgPicture.network(
          "https://www.svgrepo.com/show/502834/share-3.svg",
          color: Colors.black,
        ),
        ),
       Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CircleAvatar(
        backgroundColor: Colors.white,
        child: SvgPicture.network("https://www.svgrepo.com/show/503086/search.svg",
        color: Colors.black
        ),
        ),
      ),
      ],
    );
  }
}
