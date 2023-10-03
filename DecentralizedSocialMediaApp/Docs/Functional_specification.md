# Functional Specification Decentralized Social Media Platform
[<img src="https://www.presse-citron.net/app/uploads/2020/06/linkedin-logo.jpg"  width="20px" align=right>](https://www.linkedin.com/in/r%C3%A9my-charles-2a8960232/)
[<img src="https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png" width="20" align="right">](https://github.com/RemyCHARLES)
| Author | Picture |
| :--- | :--- |
| **Rémy Charles** | <img src="https://ca.slack-edge.com/T019N8PRR7W-U0338M4B32R-2e88fca92827-512" width="50px" align=center> |

## Table of Contents

<details><summary> Click to expand </summary>

- [Functional Specification Decentralized Social Media Platform](#functional-specification-decentralized-social-media-platform)
  - [Table of Contents](#table-of-contents)
  - [1. Introduction](#1-introduction)
  - [2. System Overview](#2-system-overview)
  - [3. Functional Requirements and Use Cases](#3-functional-requirements-and-use-cases)
    - [3.1 User Registration and Authentication](#31-user-registration-and-authentication)
      - [Use Case: User Registration](#use-case-user-registration)
    - [3.2 User Profile Management](#32-user-profile-management)
      - [Use Case: Update User Profile](#use-case-update-user-profile)
    - [3.3 Content Sharing](#33-content-sharing)
      - [Use Case: Create and Share a Post](#use-case-create-and-share-a-post)
    - [3.4 Post Interaction](#34-post-interaction)
      - [Use Case: Interact with a Post](#use-case-interact-with-a-post)
    - [3.5 Decentralized Transactions](#35-decentralized-transactions)
      - [Use Case: Tip a Content Creator](#use-case-tip-a-content-creator)
  - [4. Non-Functional Requirements](#4-non-functional-requirements)
    - [4.1 Security](#41-security)
    - [4.2 Privacy](#42-privacy)
    - [4.3 Scalability](#43-scalability)
    - [4.4 User Experience](#44-user-experience)
  - [5. Conclusion](#5-conclusion)

</details>

____


App Name: [Undefined] </br>
Business Plan: [Undefined]

## 1. Introduction

This document provides detailed functional specifications and use cases for the development of a decentralized social media platform. It outlines the system's key features, expected behavior, and user interactions.

## 2. System Overview

The platform aims to leverage blockchain technology to enhance user privacy and data ownership in the social media landscape. Key functionalities include user registration, profile management, content sharing, post interaction, and decentralized transactions.

## 3. Functional Requirements and Use Cases

### 3.1 User Registration and Authentication

Users should be able to register for a new account with minimal information. The registration process will generate a unique blockchain-based identifier for each user.

#### Use Case: User Registration
- Primary Actor: New User
- Basic Flow:
  1. User selects "Sign Up" on the landing page.
  2. User provides necessary details for registration.
  3. A unique blockchain-based identifier is generated for the user.
  4. User is now registered and can log in using this identifier.

### 3.2 User Profile Management

Users should be able to manage their profiles, which includes changing profile pictures, setting a username, adding a brief bio, and updating other profile information.
#### Use Case: Update User Profile
- Primary Actor: Registered User
- Basic Flow:
  1. User logs in to the platform.
  2. User navigates to the "Profile" section.
  3. User updates their profile information and saves changes.
  4. Updated information is stored in a decentralized manner.

### 3.3 Content Sharing

Users should be able to create, edit, and delete posts. Posts can be text, images, videos, or links. 

#### Use Case: Create and Share a Post
- Primary Actor: Registered User
- Basic Flow:
  1. User logs in to the platform.
  2. User selects the option to "Create a Post".
  3. User inputs the content of the post (text, image, video, or link) and selects "Post".
  4. The post is stored using a decentralized storage system like IPFS or Filecoin, and it's displayed on the platform.

### 3.4 Post Interaction

Users should be able to interact with posts. This includes liking, commenting, and sharing posts. 

#### Use Case: Interact with a Post
- Primary Actor: Registered User
- Basic Flow:
  1. User logs in to the platform.
  2. User browses through the posts.
  3. User selects a post and performs an action (like, comment, share).
  4. The action is recorded on the blockchain.

### 3.5 Decentralized Transactions

The platform should support decentralized transactions. For example, users should be able to tip content creators using cryptocurrency.

#### Use Case: Tip a Content Creator
- Primary Actor: Registered User
- Basic Flow:
  1. User logs in to the platform.
  2. User selects a post by a content creator they want to tip.
  3. User selects the "Tip" option and chooses the amount to tip.
  4. A smart contract executes the transaction, transferring the cryptocurrency from the user to the content creator.

## 4. Non-Functional Requirements

### 4.1 Security

The platform should use robust encryption methods to ensure the security of user data. Transactions should be secure and free from vulnerabilities.

### 4.2 Privacy

The platform should protect user privacy by giving users control over their data. User data should not be accessible to third parties without explicit user consent.

### 4.3 Scalability

The platform should be designed to handle a large number of users and transactions without performance degradation. It should be capable of scaling as user numbers grow.

### 4.4 User Experience

The platform should offer an intuitive and smooth user experience. The user interface should be simple yet attractive, with easy navigation.

## 5. Conclusion

This document provides a high-level functional specification and use cases for the development of a decentralized social media platform. The platform's key functions include user registration and authentication, user profile management, content sharing, post interaction, and decentralized transactions. With user privacy and data ownership at the forefront of this project, this platform aims to revolutionize the current social media landscape.

