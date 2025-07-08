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

<div align="center">
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.36_9ece40d2.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.36_f413d86a.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.37_74b04071.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.37_82cd1718.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.37_9d8c6fda.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.38_69f99052.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.38_8466a3a4.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.38_c739f358.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.39_0c439888.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.39_a17421c2.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.39_cd4a004e.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.40_58155f1b.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.40_d3de4cbc.jpg" width="160" style="margin:4px;" />
  <img src="Demo/screenshots/WhatsApp Image 2025-07-08 at 11.09.40_ea80660d.jpg" width="160" style="margin:4px;" />
</div>


---



## 🎥 Demo Video

**[Click here to watch the demo video](https://drive.google.com/file/d/17YKkntm_VwRFaQIG2QbMQlLSxTvGnYzg/view?usp=drive_link)**

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
