
class AppUser {
  final String uid;
  final String email;
  final String username;
  final String profilePicUrl;
  final List<String> followers;
  final List<String> following;

  AppUser({
    required this.uid,
    required this.email,
    required this.username,
    required this.profilePicUrl,
    required this.followers,
    required this.following,
  });

  factory AppUser.fromMap(Map<String, dynamic> data) {
    return AppUser(
      uid: data['uid'],
      email: data['email'],
      username: data['username'],
      profilePicUrl: data['profilePicUrl'],
      followers: List<String>.from(data['followers']),
      following: List<String>.from(data['following']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profilePicUrl': profilePicUrl,
      'followers': followers,
      'following': following,
    };
  }
}
