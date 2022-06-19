import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nft_marketplace/models/user_model.dart';
import 'package:nft_marketplace/models/nft_model.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // USER DATA

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future setUserData(String firstname, String lastname, String username,
      String useremail) async {
    return await usersCollection.doc(uid).set({
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'useremail': useremail,
      'balance': 0,
      'nftpublished': 0,
      'followers': 0,
      'following': 0,
    });
  }

  Future updateUserData(
      String firstname, String lastname, String username) async {
    return await usersCollection.doc(uid).update(
        {'firstname': firstname, 'lastname': lastname, 'username': username});
  }

  Future updateBalance(int balance) async {
    return await usersCollection.doc(uid).update({'balance': balance});
  }

  Future updateNFTPublished(int nftpublished) async {
    return await usersCollection
        .doc(uid)
        .update({'nftpublished': nftpublished});
  }

  Future updateFollowers(int followers) async {
    return await usersCollection.doc(uid).update({'followers': followers});
  }

  Future updateFollowing(int following) async {
    return await usersCollection.doc(uid).update({'following': following});
  }

  UserData _userdataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstname: snapshot.get('firstname'),
      lastname: snapshot.get('lastname'),
      username: snapshot.get('username'),
      useremail: snapshot.get('useremail'),
      balance: snapshot.get('balance'),
      nftpublished: snapshot.get('nftpublished'),
      followers: snapshot.get('followers'),
      following: snapshot.get('following'),
    );
  }

  Stream<UserData> get usersdata {
    return usersCollection.doc(uid).snapshots().map(_userdataFromSnapshot);
  }

  // NFTs

  final CollectionReference nftCollection =
      FirebaseFirestore.instance.collection('nfts');

  List<NFT> _nftListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return NFT(
          creator: (doc.data() as dynamic)['creator'] ?? '',
          title: (doc.data() as dynamic)['title'] ?? '',
          price: (doc.data() as dynamic)['price'] ?? 0);
    }).toList();
  }

  Stream<List<NFT>>? get nfts {
    return nftCollection.snapshots().map(_nftListFromSnapshot);
  }
}
