# Functional Specification - Decentralized Social Media Platform

[<img src="https://www.presse-citron.net/app/uploads/2020/06/linkedin-logo.jpg"  width="20px" align=right>](https://www.linkedin.com/in/r%C3%A9my-charles-2a8960232/)
[<img src="https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png" width="20" align="right">](https://github.com/RemyCHARLES)

| **Author(s)** | Remy CHARLES |
| :------------ | :----------- |
| **Project** | Decentralized Social Media Platform |
| **Version** | 1.0 |
| **Last updated** | 2024-01-26 |

## Table of Contents

<details>

<summary>Table of Contents</summary>

- [Functional Specification - Decentralized Social Media Platform](#functional-specification---decentralized-social-media-platform)
  - [Table of Contents](#table-of-contents)
  - [1. Introduction](#1-introduction)
  - [1.1 Purpose](#11-purpose)
    - [1.2 Scope](#12-scope)
    - [1.3 Definitions, Acronyms, and Abbreviations](#13-definitions-acronyms-and-abbreviations)
    - [1.4 References](#14-references)
    - [1.5 Overview](#15-overview)
  - [2. Overall Description](#2-overall-description)
    - [2.1 Product Perspective](#21-product-perspective)
    - [2.2 Product Functions](#22-product-functions)
    - [2.3 User Characteristics](#23-user-characteristics)
    - [2.4 Constraints](#24-constraints)
    - [2.5 Assumptions and Dependencies](#25-assumptions-and-dependencies)
  - [3. System Features and Requirements](#3-system-features-and-requirements)
    - [3.1 User Accounts](#31-user-accounts)
      - [3.1.1 Registration](#311-registration)
      - [3.1.2 Profile Management](#312-profile-management)
    - [3.2 Content Management](#32-content-management)
      - [3.2.1 Posting Content](#321-posting-content)
      - [3.2.2 Content Moderation](#322-content-moderation)
    - [3.3 Cryptocurrency Integration](#33-cryptocurrency-integration)
      - [3.3.1 Wallet Integration](#331-wallet-integration)
      - [3.3.2 Token Transactions](#332-token-transactions)
    - [3.4 Social Interactions](#34-social-interactions)
      - [3.4.1 Commenting](#341-commenting)
      - [3.4.2 Liking and Sharing](#342-liking-and-sharing)
    - [3.5 Search Functionality](#35-search-functionality)
    - [3.6 Notifications](#36-notifications)
    - [3.7 Reporting and Analytics](#37-reporting-and-analytics)
  - [4. Blockchain and Smart Contract Specifications](#4-blockchain-and-smart-contract-specifications)
    - [4.1 Blockchain Selection and Cryptocurrency Integration](#41-blockchain-selection-and-cryptocurrency-integration)
    - [4.2 Smart Contract Functions for Cryptocurrency](#42-smart-contract-functions-for-cryptocurrency)
    - [4.3 Security Measures for Cryptocurrency](#43-security-measures-for-cryptocurrency)
    - [4.4 Governance Mechanisms and Cryptocurrency Utilization](#44-governance-mechanisms-and-cryptocurrency-utilization)
  - [5. User Interface Design](#5-user-interface-design)
    - [5.1 Layout and Navigation](#51-layout-and-navigation)
    - [5.2 Accessibility Considerations](#52-accessibility-considerations)
    - [5.3 Design Mockups](#53-design-mockups)
  - [6. Security Specifications](#6-security-specifications)
    - [6.1 User Data Protection](#61-user-data-protection)
    - [6.2 Transaction Security](#62-transaction-security)
    - [6.3 Platform Security Measures](#63-platform-security-measures)
  - [7. Performance Requirements](#7-performance-requirements)
    - [7.1 Load Handling](#71-load-handling)
    - [7.2 Response Times](#72-response-times)
    - [7.3 Scalability](#73-scalability)
  - [8. Quality Attributes](#8-quality-attributes)
    - [8.1 Usability](#81-usability)
    - [8.2 Reliability](#82-reliability)
    - [8.3 Maintainability](#83-maintainability)
    - [8.4 Portability](#84-portability)
  - [9. External Interface Requirements](#9-external-interface-requirements)
    - [9.1 User Interfaces](#91-user-interfaces)
    - [9.2 Hardware Interfaces](#92-hardware-interfaces)
    - [9.3 Software Interfaces](#93-software-interfaces)
    - [9.4 Communication Interfaces](#94-communication-interfaces)
  - [10. Compliance and Regulatory Requirements](#10-compliance-and-regulatory-requirements)
  - [11. Appendices](#11-appendices)
    - [11.1 Supplementary Information](#111-supplementary-information)
    - [11.2 Glossary](#112-glossary)
  - [12. Index](#12-index)
  

</details>

## 1. Introduction

## 1.1 Purpose
The purpose of this document is to provide a detailed functional specification for the development of a blockchain-based social media platform. This platform aims to leverage blockchain technology to offer enhanced privacy, user empowerment, and innovative engagement methods through the use of a proprietary cryptocurrency. The document outlines the system's overall functionality, specific requirements, and user interactions.

### 1.2 Scope
This specification covers the design and development aspects of the social media platform, including user account management, content posting and interaction, cryptocurrency integration, blockchain functionality, security, and performance requirements. It will serve as a guiding framework for developers, designers, and stakeholders involved in the project.

### 1.3 Definitions, Acronyms, and Abbreviations
- Blockchain: A decentralized digital ledger that records transactions across multiple computers.
- Cryptocurrency: A digital or virtual currency secured by cryptography, operating independently of a central bank.
- Smart Contract: Self-executing contracts with the terms of the agreement directly written into code.
- MVP (Minimum Viable Product): The most basic version of a product that can be released.

### 1.4 References
- [Blockchain Technology Overview](https://www.blockchain.com/)
- [Introduction to Cryptocurrency](https://www.coinbase.com/learn/crypto-basics/what-is-cryptocurrency)

### 1.5 Overview
The document is structured to first provide an overall description of the platform, followed by detailed specifications of system features and requirements. Subsequent sections cover blockchain and smart contract specifics, user interface design, security specifications, performance requirements, quality attributes, and compliance standards. The document concludes with appendices and an index for easy navigation.

## 2. Overall Description

### 2.1 Product Perspective
The proposed social media platform is a novel application of blockchain technology, aimed at enhancing user experience in terms of privacy, ownership, and engagement. It stands apart from traditional social media platforms by integrating a custom cryptocurrency to reward users and facilitate transactions within the ecosystem.

### 2.2 Product Functions
- **User Account Management**: Secure registration and profile management.
- **Content Posting and Interaction**: Users can post content, comment, like, and share.
- **Cryptocurrency Integration**: In-platform cryptocurrency for transactions and rewards.
- **Decentralized Governance**: Community-driven content moderation and platform decisions.

### 2.3 User Characteristics
- **General Users**: Seeking a secure and private social media experience.
- **Content Creators**: Looking for fair compensation and ownership of their content.
- **Crypto-enthusiasts**: Interested in the use of cryptocurrency in social media.

### 2.4 Constraints
- **Technology Limitations**: The platform's performance is subject to blockchain scalability.
- **Regulatory Compliance**: Adherence to global cryptocurrency and data protection laws.

### 2.5 Assumptions and Dependencies
- **User Adoption**: The platform's success depends on a robust user base.
- **Technological Advancements**: Future blockchain developments could significantly impact the platform's performance and capabilities.

## 3. System Features and Requirements

### 3.1 User Accounts
#### 3.1.1 Registration
- **Blockchain-Based Authentication**: Users create accounts using blockchain-based authentication methods. This can be done through cryptographic keys or digital wallets (like MetaMask, WalletConnect).
- **Decentralized Identity (DID)**: Implement a decentralized identity system where users control their identity without relying on centralized services. DID can be stored on the blockchain, ensuring security and privacy.
- **Recovery Mechanism**: Provide a secure method for account recovery, such as a mnemonic phrase or backup keys, in case of lost access to the user's blockchain wallet.
- **Privacy-Preserving**: No collection of personal data like email addresses, ensuring user anonymity and privacy.
- **User Agreement**: Users must acknowledge and accept the decentralized nature of the platform, including the responsibilities of managing their private keys or wallet for access.


#### 3.1.2 Profile Management
- **Decentralized Profiles**: User profiles are managed via blockchain, ensuring data integrity and user control over personal information.
- **Blockchain-Backed Customization**: Profile customization, including setting profile pictures and bios, is recorded on the blockchain, providing a tamper-proof history of changes.
- **Privacy Control via Smart Contracts**: User privacy settings are managed through smart contracts, allowing users to have granular control over who can view their information and content.

### 3.2 Content Management
#### 3.2.1 Posting Content
- **Blockchain-Based Content Storage**: All user content (text, images, videos) is stored on the blockchain or decentralized storage solutions like IPFS, ensuring immutability and censorship resistance.
- **Content Authenticity Verification**: Every piece of content is hashed and recorded on the blockchain, providing proof of authenticity and origin.
- **Cryptocurrency for Content Promotion**: Users can use the platform’s cryptocurrency to promote their content. These transactions and promotions are transparently and immutably recorded on the blockchain.

#### 3.2.2 Content Moderation
- **Decentralized Moderation Mechanisms**: Implement a community-driven content moderation system backed by blockchain. Users can vote on content, with these interactions being recorded on the blockchain to ensure fairness and transparency.
- **Smart Contract for Moderation Rules**: Moderation rules are enforced through smart contracts, automating the process and reducing biased intervention.
- **Reporting and Flagging on Blockchain**: Reported content and actions taken are recorded on the blockchain, ensuring an immutable record of moderation actions for transparency and auditability.


### 3.3 Cryptocurrency Integration
#### 3.3.1 Wallet Integration
- Every user account comes with an integrated digital wallet, compatible with the platform's cryptocurrency.
- Features include secure storage, transaction history, and easy management of cryptocurrency assets.
- Functions to transfer and receive tokens to and from other users within the platform, with minimal transaction fees.

#### 3.3.2 Token Transactions
- Users can earn tokens by creating engaging content that receives likes, shares, and comments.
- Tokens can be used to access premium features, such as enhanced visibility of posts or exclusive content.
- All transactions are recorded on the blockchain, providing transparency and an immutable record of all transfers and earnings.

### 3.4 Social Interactions
#### 3.4.1 Commenting
- Users can comment on posts, with a nested reply feature to foster discussion.
- Likes and upvotes for comments to highlight popular opinions or valuable contributions.
- Reporting mechanism for inappropriate comments, with a moderation queue to review reported content.

#### 3.4.2 Liking and Sharing
- Various reaction options (like, love, insightful) to enable users to express their feelings about a post.
- Sharing functionality within the platform and external platforms, with privacy-compliant sharing options.
- Analytics for users to track how many likes, shares, and reactions their posts receive.

### 3.5 Search Functionality
- Advanced search functionality to find content, users, or trends using keywords, hashtags, and user tags.
- User-friendly and intuitive interface, with auto-suggestions and recent searches.
- Customizable filters to sort search results by date, relevance, popularity, or content type.

### 3.6 Notifications
- Instant notifications for interactions like comments, likes, and new followers, with real-time updates.
- Notification settings panel where users can customize the types of notifications received and their frequency.
- System alerts for important announcements, updates, or security notices from the platform.

### 3.7 Reporting and Analytics
- Personalized dashboard for users to monitor their content engagement, cryptocurrency earnings, and wallet transactions.
- Detailed analytics offering insights into content reach, audience demographics, and interaction patterns.
- Regular reports on cryptocurrency transactions, including earnings, expenditures, and wallet balance, with options to export data.

## 4. Blockchain and Smart Contract Specifications

### 4.1 Blockchain Selection and Cryptocurrency Integration
The selection of a blockchain platform will be a foundational decision, taking into account scalability, transaction costs, and compatibility with our custom cryptocurrency. We are considering established platforms like Ethereum for its robust smart contract capabilities, but we're also open to newer or custom-built blockchains that may offer better scalability and lower transaction fees, which are crucial for our cryptocurrency. The chosen blockchain will need to support the unique features and requirements of our cryptocurrency, including secure transactions, wallet integration, and token distribution. Interoperability with other blockchains will be an important consideration for future expansions and collaborations.

### 4.2 Smart Contract Functions for Cryptocurrency
Our platform will utilize smart contracts extensively, not just for user interactions, but crucially for managing the functionalities of our proprietary cryptocurrency. These contracts will handle aspects such as the issuance of tokens, processing transactions, and managing rewards for users. Additionally, smart contracts will be employed to automate content moderation and uphold privacy settings, creating a self-regulating platform environment. The development of these contracts will prioritize efficiency and minimal transaction costs to maintain a user-friendly experience, especially in relation to cryptocurrency transactions.


### 4.3 Security Measures for Cryptocurrency
Ensuring the security of our cryptocurrency is paramount. Regular audits will be conducted to safeguard against vulnerabilities, especially in the smart contracts that manage the cryptocurrency. We will implement robust security measures for the decentralized storage of user data and content, critical for maintaining the integrity of the platform and its cryptocurrency. Fraud and abuse prevention systems will be integrated, utilizing the security features of blockchain technology such as immutability and transparency, to protect against malicious activities within the cryptocurrency ecosystem.


### 4.4 Governance Mechanisms and Cryptocurrency Utilization
Our platform will embrace a decentralized governance model, where key decisions are made by the community of users through a transparent voting mechanism facilitated by our cryptocurrency. This approach ensures that users who are invested in the platform have a say in its evolution. The governance model will be implemented through smart contracts, allowing for secure and transparent voting processes. Proposals for platform changes or new features can be made and voted on using the cryptocurrency, with results being recorded on the blockchain. This system not only empowers users but also enhances the utility and importance of the cryptocurrency within the platform.

## 5. User Interface Design

### 5.1 Layout and Navigation

### 5.2 Accessibility Considerations

### 5.3 Design Mockups

## 6. Security Specifications

### 6.1 User Data Protection

### 6.2 Transaction Security

### 6.3 Platform Security Measures

## 7. Performance Requirements

### 7.1 Load Handling

### 7.2 Response Times

### 7.3 Scalability

## 8. Quality Attributes

### 8.1 Usability

### 8.2 Reliability

### 8.3 Maintainability

### 8.4 Portability

## 9. External Interface Requirements

### 9.1 User Interfaces

### 9.2 Hardware Interfaces

### 9.3 Software Interfaces

### 9.4 Communication Interfaces

## 10. Compliance and Regulatory Requirements

## 11. Appendices

### 11.1 Supplementary Information

### 11.2 Glossary

## 12. Index

