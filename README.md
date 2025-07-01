<img src = "[https://github.com/user-attachments/assets/64fade4f-7120-4ff8-9c5f-3a07b353f91d](https://github.com/user-attachments/assets/b7165107-f408-4b57-9dfe-85dc749aabdf)" width = 200>
# BlogSphere 📝✨

**BlogSphere** is a full-featured social blogging app built using **Flutter** and **Firebase**. It enables users to create, view, and engage with blog content in real-time. The app features likes, comments, user profiles, and following functionality — all tied together with a clean and responsive UI.

---

## 🚀 Features

- ✍️ **Create, edit, and delete blogs**
- ❤️ **Like and comment** on posts
- 🧑‍🤝‍🧑 **Follow/unfollow** other users
- 🌐 **Explore all posts** or filter by followed users
- 👤 **User profiles** with follower/following counts
- 📸 **Profile pictures** with cached image loading
- 🔐 **Firebase Auth** for secure login/signup
- 🔄 **Real-time updates** with Firestore and Provider

---

## 📷 Screenshots

<img src="https://github.com/user-attachments/assets/profile-sample-1.png" width="200">
<img src="https://github.com/user-attachments/assets/profile-sample-2.png" width="200">
<img src="https://github.com/user-attachments/assets/profile-sample-3.png" width="200">

---

## 🎥 Screen Recording

▶️ [Watch Demo on Google Drive](https://drive.google.com/file/d/15iWAOUeqg2N_NMOPcqrONHKAEp3uwlzq/view?usp=drivesdk)

---

## 🧱 Firestore Database Schema

### `users (Collection)`
| Field         | Type    | Description                            |
|---------------|---------|----------------------------------------|
| uid           | String  | Firebase UID                           |
| username      | String  | Display name                           |
| email         | String  | User email                             |
| profilePicUrl | String  | Profile photo URL                      |
| followers     | List    | UIDs of users who follow this user     |
| following     | List    | UIDs of users this user is following   |

### `blogs (Collection)`
| Field       | Type    | Description                        |
|-------------|---------|------------------------------------|
| blogId      | String  | Auto-generated ID                  |
| authorId    | String  | UID of the author                  |
| authorName  | String  | Name of the author                 |
| title       | String  | Blog title                         |
| content     | String  | Blog body                          |
| timestamp   | DateTime| Time of creation                   |
| likes       | List    | UIDs who liked the post            |

### `comments (Subcollection under blogs/{blogId}/comments)`
| Field        | Type    | Description                        |
|--------------|---------|------------------------------------|
| commentId    | String  | Auto-generated ID                  |
| commenterId  | String  | UID of the commenter               |
| content      | String  | Comment text                       |
| timestamp    | DateTime| Time of comment                    |

---

## 📱 Tech Stack

- **Flutter** & **Dart**
- **Firebase Auth** for user login/signup
- **Cloud Firestore** for blogs, users, and comments
- **Provider** for state management
- **CachedNetworkImage** for profile pictures

---

## 📦 Packages Used

- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `provider`
- `cached_network_image`

---

## 🧑‍🎓 Student Details

- **Name:** A. V. S. Manoj  
- **Roll No:** 23110025  
- **College:** IIT Gandhinagar  
- **Discipline:** Computer Science and Engineering (CSE)

---

## 📝 Notes

> This project was developed as part of the **Week 4 assignment** for the Flutter + Firebase App Development course.  
> The app demonstrates best practices in authentication, Firestore schema design, and clean Flutter architecture.

---

