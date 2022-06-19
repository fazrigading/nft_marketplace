import 'package:flutter/material.dart';
import '../pages/detailspage.dart';

class DetailsButton extends StatefulWidget {
  const DetailsButton(
      {Key? key,
      required this.kreator,
      required this.judul,
      required this.harga,
      required this.gambar,
      required this.kreatorImg})
      : super(key: key);
  final String kreator;
  final String judul;
  final int harga;
  final String gambar;
  final String kreatorImg;

  @override
  State<DetailsButton> createState() => _DetailsButtonState();
}

class _DetailsButtonState extends State<DetailsButton> {
  @override
  Widget build(BuildContext context) {
    // bool notFavorited;
    // final IconData favoriteIcon =
    //     notFavorited ? Icons.favorite : Icons.favorite_border;
    return Container(
      margin: const EdgeInsets.only(top: 375),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(18.0),
            elevation: 5,
            color: const Color.fromRGBO(18, 18, 18, 1),
            child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              kreator: widget.kreator,
                              judul: widget.judul,
                              harga: widget.harga,
                              gambar: widget.gambar,
                              kreatorImg: widget.kreatorImg,
                            )),
                  );
                },
                minWidth: 158,
                height: 58,
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
          ),
          Material(
            borderRadius: BorderRadius.circular(18.0),
            elevation: 5,
            color: const Color.fromRGBO(13, 183, 183, 1),
            child: MaterialButton(
                onPressed: () {
                  setState(() {
                    // notFavorited = true;
                    // notFavorited ? true : false;
                  });
                },
                minWidth: 58,
                height: 58,
                child: const Icon(Icons.favorite_outline, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class Creator extends StatelessWidget {
  const Creator(
      {Key? key,
      required this.gambar,
      required this.nama,
      required this.pengikut})
      : super(key: key);
  final String gambar;
  final String nama;
  final String pengikut;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 93,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        color: const Color.fromRGBO(236, 236, 236, 1),
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: ListTile(
          leading: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image:
                  DecorationImage(image: AssetImage(gambar), fit: BoxFit.cover),
            ),
          ),
          title: Text(
            nama,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            "$pengikut followers",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

class Creators extends StatelessWidget {
  const Creators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Creator(
            gambar: 'assets/thewatcher.png',
            nama: 'The Watcher',
            pengikut: '576'),
        Creator(
            gambar: 'assets/zeffhood.png', nama: 'Zeff Hood', pengikut: '892'),
        Creator(
            gambar: 'assets/jayanrobs.png',
            nama: 'Jayan Robs',
            pengikut: '707'),
      ],
    );
  }
}
