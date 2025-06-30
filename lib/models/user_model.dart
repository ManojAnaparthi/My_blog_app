
class AppUser {
  final String uid;
  final String username;
  final String email;
  final String profilePicUrl;
  final List<String> followers;
  final List<String> following;

  AppUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicUrl,
    required this.followers,
    required this.following,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'],
      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'followers': followers,
      'following': following,
    };
  }
}
