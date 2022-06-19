import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nft_marketplace/pages/publishnft.dart';
import 'package:nft_marketplace/pages/topuppage.dart';
import 'package:provider/provider.dart';
import '../constants/button.dart';
import '../objects/nftlist.dart';
import 'profilepage.dart';
import '../services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, firstName, lastName}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BottomNavigationBarItem> _bottomItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.add_photo_alternate), label: "Publish"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];
  final List<Widget> _myPages = [
    ListView(
      children: const [
        SubmenuTitles(teks: 'Featured NFTs'),
        FeaturedNFT(),
        SubmenuTitles(teks: 'Featured Creators'),
        Creators(),
      ],
    ),
    const PublishNFT(),
    const ViewProfile(),
  ];
  final List<String> listjudulhalaman = [
    "NFT Market App",
    "Publish",
    "Profile"
  ];
  int _indexBottom = 0;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(18, 183, 183, 1),
        elevation: 5,
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(18, 183, 183, 1),
              ),
              child: Center(
                child: Text(
                  "Welcome to the\nbest of the best\nNFT Marketplace App!",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text("Home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Get.back();
                setState(() {
                  _indexBottom = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
              ),
              title: const Text("Publish NFT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Get.back();
                setState(() {
                  _indexBottom = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text("Profile",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Get.back();
                setState(() {
                  _indexBottom = 2;
                });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
              title: const Text("Top-Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Get.back();
                Get.to(const TopUpPage());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: const Text("Favorites",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.category_sharp,
                color: Colors.white,
              ),
              title: const Text("Categories",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              title: const Text("Invite Friend",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              title: const Text("Settings",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {
                Get.back();
                Get.toNamed('/settingpage');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: const Text("About",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              onTap: () {},
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text("Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  onTap: () async {
                    c.cleanform();
                    c.cleanformnft();
                    await authService.signOff();
                    Get.offAllNamed('/loginpage');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        toolbarHeight: 70,
        title: Text(
          listjudulhalaman[_indexBottom],
          style: const TextStyle(
              fontFamily: 'Manrope',
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  Get.to(const TopUpPage());
                },
                icon: const Icon(Icons.account_balance_wallet)),
          )
        ],
      ),
      body: _myPages.elementAt(_indexBottom),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomItem,
        currentIndex: _indexBottom,
        onTap: (int index) {
          setState(() {
            _indexBottom = index;
          });
        },
      ),
    );
  }
}

class SubmenuTitles extends StatelessWidget {
  const SubmenuTitles({Key? key, required this.teks}) : super(key: key);
  final String teks;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            teks,
            style: const TextStyle(
              color: Color.fromRGBO(18, 18, 18, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
              onPressed: () {
                Get.toNamed('/categorypage');
              },
              style: TextButton.styleFrom(
                  primary: const Color.fromRGBO(132, 132, 132, 1)),
              child: const Text('View all'))
        ]));
  }
}
