import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/menu_card.dart';
import 'package:flutter_application_1/components/restaruant_categories.dart';
import 'package:flutter_application_1/components/restaurant_info.dart';
import 'package:flutter_application_1/models/menu.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController= ScrollController();
  int selectedCategoryIndex=0;
  double restaurantInfoHeight= 200+170-kToolbarHeight; 

  @override
  void initState() {
    createBreackPoints();
    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
     });
     super.initState();
  }
 @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  void scrollToCategory(int index){
  if(selectedCategoryIndex != index){
    int totalItems=0;
       for(var i=0; i<index; i++){
      totalItems += demoCategoryMenus[i].items.length;
    }
    scrollController.animateTo(
    restaurantInfoHeight + (116* totalItems) +(50*index),
     duration: const Duration(milliseconds: 500),
     curve: Curves.ease
      );
      setState(() {
        selectedCategoryIndex= index;
      });
  }
  }
  List<double> breackPoints= [];
  void createBreackPoints() {
    double firstBreackPoint = restaurantInfoHeight + 50+(116* demoCategoryMenus[0].items.length);
    breackPoints.add(firstBreackPoint);
    for(var i=0; i<demoCategoryMenus.length; i++){
      double breackPoint = 
      breackPoints.last + (116* demoCategoryMenus[i].items.length);
      breackPoints.add(breackPoint);
    }
  }
  void updateCategoryIndexOnScroll(double offset){
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if(i==0){
        if((offset < breackPoints.first) & (selectedCategoryIndex !=0)){
          setState(() {
            selectedCategoryIndex=0;
          });
        }
      }
      else if((breackPoints[i-1]<=offset)&(offset<breackPoints[i])){
        if(selectedCategoryIndex!=i){
          setState(() {
            selectedCategoryIndex=i;
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
         const Restaurantappbar(),
        const SliverToBoxAdapter(
          child:  RestaurantInfo(),
          ),
          SliverPersistentHeader(
            delegate: RestaruantCategories(
              onChanged: scrollToCategory,
              selectedIndex: selectedCategoryIndex,
              ),
              pinned: true,
              ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, categoryIndex) {
                List<Menu> items= demoCategoryMenus[categoryIndex].items;
                return MenuCategoryItem(
                  title: demoCategoryMenus[categoryIndex].category,
                items: List.generate(
                  items.length,
                   (index) => Padding(
                     padding: const EdgeInsets.only(bottom:16),
                     child: MenuCard(
                       title: items[index].title, 
                       image: items[index].image,
                       price: items[index].price,),
                   )),
                );
              },
              childCount: demoCategoryMenus.length,
              )),
          )
        ],
      ),
    );
  }
}

class Restaurantappbar extends StatelessWidget {
  const Restaurantappbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
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
