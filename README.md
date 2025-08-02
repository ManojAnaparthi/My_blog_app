
# My Blogs

**My Blog App** is a modern, full-featured social blogging platform built with **Flutter** and **Firebase**. Seamlessly create, explore, and engage with blog posts in real time. Features include authentication, real-time updates, following, commenting, and a polished mobile UI/UX ready for production.

---

## 📑 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Demo Video](#-demo-video)
- [Firestore Database Schema](#-firestore-database-schema)
- [Tech Stack](#-tech-stack)
- [Packages Used](#-packages-used)
- [Folder Structure](#-folder-structure)
- [Student Details](#-student-details)

---

## 📁 Folder Structure

```
blog_app/
├── lib/
│   ├── models/         # Data models
│   ├── providers/      # State management
│   ├── screens/        # UI screens
│   ├── services/       # Firebase and business logic
│   ├── utils/          # Constants, validators, helpers
│   └── widgets/        # Reusable widgets
├── Demo/               # Screenshots
├── android/            # Android project files
├── ios/                # iOS project files
├── pubspec.yaml        # Dependencies and assets
└── README.md           # Project documentation
```

---

## 🚀 Features

- ✍️ Create, edit, and delete blogs
- ❤️ Like and comment on posts
- 👤 View user profiles
- 🧑‍🤝‍🧑 Follow and unfollow other users
- 🌐 Explore all blogs
- 📸 Profile pictures
- 🔐 Firebase Authentication
- 🔄 Real-time updates using Firestore and Provider

---





## 📷 Screenshots

<div align="center">
  <img src="Demo/screenshots/signup.jpg" width="160" style="margin:4px;" title="Signup" />
  <img src="Demo/screenshots/login.jpg" width="160" style="margin:4px;" title="Login" />
  <img src="Demo/screenshots/create_blog.jpg" width="160" style="margin:4px;" title="Create Blog" />
  <img src="Demo/screenshots/view_blog.jpg" width="160" style="margin:4px;" title="Explore" />
  <img src="Demo/screenshots/edit_blog.jpg" width="160" style="margin:4px;" title="Edit Blog" />
  <img src="Demo/screenshots/delete_blog.jpg" width="160" style="margin:4px;" title="Delete Blog" />
  <img src="Demo/screenshots/likes.jpg" width="160" style="margin:4px;" title="Likes" />
  <img src="Demo/screenshots/comments.jpg" width="160" style="margin:4px;" title="Comments" />
  <img src="Demo/screenshots/Appdrawer.jpg" width="160" style="margin:4px;" title="AppDrawer" />
  <img src="Demo/screenshots/u2_profile_unfollowed.jpg" width="160" style="margin:4px;" title="Profile" />
  <img src="Demo/screenshots/followers.jpg" width="160" style="margin:4px;" title="Followers" />
  <img src="Demo/screenshots/following.jpg" width="160" style="margin:4px;" title="Following" />
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
