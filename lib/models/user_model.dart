class User {
  final String? uid;
  User({this.uid});
}

class UserData {
  final String? uid;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? useremail;
  final int? balance;
  final int? nftpublished;
  final int? followers;
  final int? following;

  UserData(
      {this.uid,
      this.firstname,
      this.lastname,
      this.username,
      this.useremail,
      this.balance,
      this.nftpublished,
      this.followers,
      this.following});
}
