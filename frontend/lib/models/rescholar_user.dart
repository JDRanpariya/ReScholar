/// Custom Data Model to condense the Firebase User object into essential attributes.
class ReScholarUser {
  final String uid;
  final String profilePicture;
  final String username;
  final String email;
  bool isAnonymous;

  ReScholarUser(this.uid, this.profilePicture, this.username, this.email,
      this.isAnonymous);
}
