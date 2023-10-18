# Functional Specification - Decentralized Social Media Platform
[<img src="https://www.presse-citron.net/app/uploads/2020/06/linkedin-logo.jpg"  width="20px" align=right>](https://www.linkedin.com/in/r%C3%A9my-charles-2a8960232/)
[<img src="https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png" width="20" align="right">](https://github.com/RemyCHARLES)
| Author | Picture |
| :--- | :--- |
| **Rémy Charles** | <img src="https://ca.slack-edge.com/T019N8PRR7W-U0338M4B32R-2e88fca92827-512" width="50px" align=center> |

## Table of Contents

<details><summary> Click to expand </summary>

- [Functional Specification - Decentralized Social Media Platform](#functional-specification---decentralized-social-media-platform)
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
  - [6. Appendices](#6-appendices)

</details>


<br>

App Name: **JOYSO** </br>
Business Plan: [Undefined]

## 1. Introduction

JOYSO represents a paradigm shift in the social media world. At a time when concerns about data privacy and personal agency on centralized platforms are paramount, JOYSO emerges as a beacon of hope, promising users unparalleled control over their personal data and interactions. This document endeavors to provide a comprehensive and detailed outline of the functionalities and behaviors one can expect from JOYSO.

## 2. System Overview

Rooted in the principles of data privacy and user-centric design, JOYSO is crafted atop the Ethereum blockchain, an environment renowned for its robust smart contract functionalities. By melding the power of blockchain with the interactive nature of social media, JOYSO pledges to set a new gold standard in user privacy and data ownership. The platform is meticulously engineered to offer features like user registration, intricate profile management, diverse content sharing capabilities, interactive post functionalities, and seamless decentralized transactions.

## 3. Functional Requirements and Use Cases

### 3.1 User Registration and Authentication

JOYSO accentuates the importance of security by integrating multi-factor and biometric authentication methods, ensuring that only the genuine user can access their account.

#### Use Case: User Registration
- Primary Actor: New User
- Basic Flow:
  1. A new user is greeted with a "Sign Up" option on the homepage.
  2. Upon selection, they're prompted to input their essential registration details.
  3. The system then crafts a unique blockchain-based identifier tailored for the user.
  4. With the identifier generated, the user is ushered into the JOYSO community, free to log in using their unique credentials.

### 3.2 User Profile Management

Every user's profile is a mosaic of their identity on JOYSO. They're given ample tools and settings to craft, curate, and modify this digital identity.

#### Use Case: Update User Profile
- Primary Actor: Registered User
- Basic Flow:
  1. After securely logging in, the user can navigate to their profile domain.
  2. Here, a suite of options is available for them to adjust, be it their profile picture, display name, bio, or other personal snippets.
  3. Once satisfied, they can confirm the changes.
  4. JOYSO ensures these changes are decentralized, ensuring user data integrity and privacy.

### 3.3 Content Sharing

JOYSO is a canvas for users to express, share, and discuss. With in-built moderation tools, the platform maintains a healthy balance between freedom of expression and community guidelines.

#### Use Case: Create and Share a Post
- Primary Actor: Registered User
- Basic Flow:
  1. Logged in users have the privilege to craft posts.
  2. Depending on their mood, they can share text, images, videos, or intriguing links.
  3. Once they've laid out their content, the "Post" option will immortalize their share on JOYSO.
  4. Leveraging decentralized storage systems, like IPFS, the content remains both accessible and secure.

### 3.4 Post Interaction

Beyond just sharing, JOYSO is a hub for interaction. Users can engage with content that resonates with them, ensuring a dynamic and active community.

#### Use Case: Interact with a Post
- Primary Actor: Registered User
- Basic Flow:
  1. Browsing through the tapestry of posts, users can dive into content that piques their interest.
  2. Every post on JOYSO is equipped with a suite of interaction tools. Whether it's a simple "like", a thoughtful comment, or sharing a post to their own profile, users have multiple avenues to engage.
  2. Each interaction is not just a digital gesture; it's a transaction on the blockchain, ensuring its permanence and authenticity.
  3. The platform also offers a reporting mechanism, where users can flag content they deem inappropriate, ensuring a self-regulating community.

### 3.5 Decentralized Transactions

At its core, JOYSO is more than just a social platform. It embodies the principles of decentralization by enabling peer-to-peer transactions, thus blurring the lines between social interaction and decentralized finance.

#### Use Case: Tip a Content Creator
- Primary Actor: Registered User
- Basic Flow:
  1. If a user stumbles upon content that they particularly appreciate, they can show their gratitude by sending a tip to the content creator.
  2. This is achieved by selecting the "Tip" option associated with the post.
  3. The user can choose the amount they wish to tip and confirm the transaction.
  4. Leveraging the power of Ethereum's smart contracts, the tip is directly transferred to the content creator's account, bypassing any middlemen.

## 4. Non-Functional Requirements

### 4.1 Security

Every piece of data on JOYSO is treated as a precious entity. To ensure its sanctity, the platform employs RSA encryption, a gold standard in data security. All transactions, be it social interactions or monetary transfers, are conducted securely using established blockchain protocols.

### 4.2 Privacy

In a world rife with data breaches and invasive advertising, JOYSO stands apart by championing user privacy. The platform is rigorously designed to be compliant with GDPR and various other international standards. Every piece of user data remains an enigma, accessible only if explicit consent is provided by the user.

### 4.3 Scalability

JOYSO is not just built for the present but also for the future. Its infrastructure is meticulously designed to accommodate an influx of users and transactions, ensuring the platform remains fluid and responsive, irrespective of its user base size.

### 4.4 User Experience

The soul of JOYSO lies in its user-centric design. Every pixel, every feature is curated to ensure a seamless, intuitive, and enriching user experience. Navigation is fluid, interfaces are crisp, and interactions are fulfilling, ensuring users find both comfort and joy in using the platform.

## 5. Conclusion

JOYSO isn't just another social media platform; it's a vision for the future. A future where users are in command, where interactions are genuine, and where data is sacrosanct. Through this document, we've endeavored to provide a glimpse into the myriad functionalities and principles that underpin JOYSO. As development progresses, further updates and timelines will be shared with our esteemed community.

## 6. Appendices

- **Glossary**: A compendium of blockchain and platform-specific terms explained for the layman.
- **References**: A collection of research papers, insightful articles, and diverse resources that have shaped and influenced the ideation and development of JOYSO.

**Feedback**: We cherish community insights. For any comments, queries, or suggestions, kindly [reach out to us](mailto:remy.charles@algosup.com).

