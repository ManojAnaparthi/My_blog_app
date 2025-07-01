# My Blog App 📝✨

**My Blog App** is a full-featured social blogging platform built using **Flutter** and **Firebase**. It allows users to create, explore, and engage with blog posts in real time. Users can like, comment, follow others, and manage their own content with ease.

---

## 🚀 Features

- ✍️ Create, edit, and delete blogs
- ❤️ Like and comment on posts
- 👤 View user profiles
- 🧑‍🤝‍🧑 Follow and unfollow other users
- 🌐 Explore all blogs or filter by followed users
- 📸 Profile pictures with caching support
- 🔐 Firebase Authentication
- 🔄 Real-time updates using Firestore and Provider

---

## 📷 Screenshots

<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/35db1c06-1fb8-4143-9bbb-f84dc3f8b08b)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/da2ecf97-733b-42ca-ab3a-0fc14c3657cc)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/189dca73-bb1a-4dd6-9eac-c12804e0f169)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/10ddd4b3-6ff6-4c8e-a99f-b5b8a8f9ab32)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/2c68b401-ad1f-499e-befd-7b49da1e4871)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/03d07824-d44f-4f27-9734-3b768f161cfa)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/d2466976-1505-4a9b-95a0-b4c9913aed87)" width="200">
<img src="[https://github.com/user-attachments/assets/profile-sample-1.png](https://github.com/user-attachments/assets/c3a50340-a55a-4e28-8abf-283947cbea0f)" width="200">


---

## 🎥 Screen Recording

▶️ [Watch Demo]()

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
> It demonstrates key concepts in authentication, Firestore schema design, and responsive Flutter app architecture.

---
