import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingImage extends StatelessWidget {
  const LandingImage({Key? key, required this.imageAddress}) : super(key: key);
  final String imageAddress;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imageAddress), fit: BoxFit.fitHeight)),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  int _current = 0;
  final CarouselController _carouselCtrl = CarouselController();
  final List<Widget> landingImages = const [
    LandingImage(imageAddress: 'assets/landingpageimg.png'),
    LandingImage(imageAddress: 'assets/meka8491.png'),
    LandingImage(imageAddress: 'assets/pudgypenguin1528.png'),
    LandingImage(imageAddress: 'assets/boredape8854.png'),
    LandingImage(imageAddress: 'assets/azuki6184.png'),
    LandingImage(imageAddress: 'assets/gutterrat1780.png'),
    LandingImage(imageAddress: 'assets/azuki6905.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CarouselSlider(
            items: landingImages,
            carouselController: _carouselCtrl,
            options: CarouselOptions(
                viewportFraction: 1,
                height: 600,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 325,
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      blurRadius: 12,
                      color: Colors.black26)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: landingImages.asMap().entries.map((entry) {
                        return GestureDetector(
                            onTap: () => _carouselCtrl.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ));
                      }).toList()),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Discover Rare\nCollectibles",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Buy and Bid Rare Collectibles from\nTop Artists.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(18, 18, 18, 0.6)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed('/wrapper');
                  },
                  child: Container(
                    height: 65,
                    width: 340,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(13, 183, 183, 1),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: const Center(
                      child: Text(
                        "Explore NFTs",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        )
      ],
    ));
  }
}
