# Functional Specification Document: The Vet App
[<img src="https://www.presse-citron.net/app/uploads/2020/06/linkedin-logo.jpg"  width="20px" align=right>](https://www.linkedin.com/in/r%C3%A9my-charles-2a8960232/)
[<img src="https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png" width="20" align="right">](https://github.com/RemyCHARLES)
| Author | Picture |
| :--- | :--- |
| **Rémy Charles** | <img src="https://ca.slack-edge.com/T019N8PRR7W-U0338M4B32R-2e88fca92827-512" width="50px" align=center> |



**Date Created**: 2023-04-25 <br>
**Date Last Modified**: 2023-04-25

___

<details><summary>Table of Contents</summary>

- [Functional Specification Document: The Vet App](#functional-specification-document-the-vet-app)
  - [Introduction](#introduction)
    - [**Scope**](#scope)
    - [**Objectives**](#objectives)
    - [**Assumptions**](#assumptions)
  - [**Use Cases**](#use-cases)
  - [**Functional Requirements**](#functional-requirements)
  - [**Non-Functional Requirements**](#non-functional-requirements)
  - [Features and Functionalities](#features-and-functionalities)
  - [Technical Requirements](#technical-requirements)
  - [Conclusion](#conclusion)

</details>

___

## Introduction

The Vet App is a mobile application designed to help pet owners calculate the appropriate amount of pet food to give to their puppies based on various factors such as breed, weight, and sterilization status. The app will use artificial intelligence (AI) to provide personalized nutritional recommendations for each puppy. The primary goal of this app is to help pet owners ensure that their puppies receive the appropriate nutrition they need to thrive.

<br>

### **Scope**

The Vet App will provide personalized nutritional recommendations based on a puppy's breed, weight, activity level, and other relevant factors. The app will also include a food calculator to help pet owners calculate the appropriate amount of food to give to their puppies based on various factors such as breed, weight, and sterilization status. The app will also use AI to develop predictive models that can accurately predict a puppy's nutritional requirements based on its specific characteristics.

<br>

### **Objectives**

The objectives of The Vet App are:

- To help pet owners ensure that their puppies receive the appropriate nutrition they need to thrive.
- To provide personalized nutritional recommendations based on a puppy's breed, weight, activity level, and other relevant factors.
- To include a food calculator to help pet owners calculate the appropriate amount of food to give to their puppies based on various factors such as breed, weight, and sterilization status.
- To use AI to develop predictive models that can accurately predict a puppy's nutritional requirements based on its specific characteristics.
  
  <br>

### **Assumptions**

The following assumptions have been made for The Vet App:

- Pet owners will have accurate information about their puppies' breed, weight, age, and sterilization status.
- The AI models will be trained on a large dataset of pet nutrition information.
- The app will be compatible with iOS and Android devices.
- The app will be user-friendly and easy to navigate.

<br>

## **Use Cases**

The Vet App will cater to the following use cases:

| Use Case | Name | Description |
| :--- | :--- | :--- |
| **UC-1** | A Bernese Mountain Dog breeder who needs to track the nutritional needs of all their animals quickly. | The Bernese Mountain Dog breeder will be able to create a profile for each of their animals, and the app will provide personalized nutritional recommendations for each animal based on their breed, weight, age, and other relevant factors. The breeder will also be able to calculate the appropriate amount of food to give to their animals based on various factors such as breed, weight, and sterilization status. |
| **UC-2** | A young family living in an apartment who wants to add a small sterilized Yorkie Terrier puppy to their family, but is unsure how much to feed the pet. | The young family will be able to create a profile for their Yorkie Terrier puppy, and the app will provide personalized nutritional recommendations based on their puppy's breed, weight, age, and other relevant factors. The family will also be able to calculate the appropriate amount of food to give to their puppy based on various factors such as breed, weight, and sterilization status. |
| **UC-3** | A veterinarian who wants an application to remotely monitor their clients' animals. | The veterinarian will be able to create profiles for their clients' animals, and the app will provide personalized nutritional recommendations for each animal based on their breed, weight, age, and other relevant factors. The veterinarian will also be able to calculate the appropriate amount of food to give to their clients' animals based on various factors such as breed, weight, and sterilization status. |

<br>

## **Functional Requirements**

The Vet App will have the following functional requirements:

| ID | Description |
| :--- | :--- |
| **FR-1** | The app will provide personalized nutritional recommendations based on a puppy's breed, weight, activity level, and other relevant factors. |
| **FR-2** | The app will include a food calculator to help pet owners calculate the appropriate amount of food to give to their puppies based on various factors such as breed, weight, and sterilization status. |
| **FR-3** | The app will use AI to develop predictive models that can accurately predict a puppy's nutritional requirements based on its specific characteristics. |
| **FR-4** | The app will include reminders to help pet owners remember to feed their puppies on time. |

## **Non-Functional Requirements**

The Vet App will have the following non-functional requirements:

| ID | Name | Description |
| :--- | :--- | :--- |
| **NFR-1** | Performance | The app should respond quickly to user input and provide accurate nutritional recommendations within seconds. |
| **NFR-2** | Security | User data should be encrypted and stored securely in the database to prevent unauthorized access. |
| **NFR-3** | Scalability | The app should be able to handle a large number of users and pets without compromising performance. |
| **NFR-4** | User Interface | The app should have a user-friendly interface that is easy to navigate and understand, with clear instructions for using the food calculator and other features. |
| **NFR-5** | Accessibility | The app should be designed with accessibility in mind, including features such as text-to-speech and large font sizes for users with visual impairments. |
| **NFR-6** | Availability | The app should be available 24/7 with minimal downtime for maintenance and updates. |
| **NFR-7** | Compatibility | The app should be compatible with a wide range of mobile devices and operating systems, including iOS and Android. |
| **NFR-8** | Reliability | The app should be reliable and provide accurate nutritional recommendations to pet owners, with minimal errors or bugs. |

<br>

## Features and Functionalities

The Vet App will have the following features and functionalities:

- **Pet Profile Creation** <br>
   Pet owners will be able to create a profile for their puppies by entering their breed, weight, age, and sterilization status. This information will be used to provide personalized nutritional recommendations.

   <br>

- **Personalized Nutritional Recommendations** <br>
    The app will use AI to provide personalized nutritional recommendations for each puppy. The app will analyze data on a puppy's breed, weight, activity level, and other relevant factors to determine the ideal amount and type of food and nutrition required for optimal health. The AI component of the app will use machine learning algorithms to develop predictive models that can accurately predict a puppy's nutritional requirements based on its specific characteristics. The app will also be designed to adapt and improve over time as it receives more data and feedback from users.

    <br>

- **Food Calculator** <br>
    The app will include a food calculator that will enable pet owners to calculate the appropriate amount of pet food to give to their puppies based on various factors such as breed, weight, and sterilization status. This feature will allow pet owners to ensure that their puppies are receiving the appropriate amount of food for their needs.

    <br>

- **AI-powered Analytics** <br>
    The app will use machine learning algorithms to analyze data on a puppy's breed, weight, activity level, and other relevant factors to develop predictive models that can accurately predict a puppy's nutritional requirements based on its specific characteristics. The AI component of the app will continuously learn and improve over time as it receives more data and feedback from users. This will allow the app to provide increasingly accurate and personalized nutritional recommendations, which will help pet owners ensure that their puppies receive the appropriate nutrition they need to thrive.

    <br>

- **Reminders** <br>
    The app will include reminders to help pet owners remember to feed their puppies on time. This feature will help pet owners ensure that their puppies receive the appropriate amount of food for their needs.

    <br>

## Technical Requirements

The Vet App will be a mobile application that will be compatible with iOS and Android devices. The app will be developed using the following technologies:

- **Frontend:** React Native <br>
    The frontend of the app will be developed using React Native, which is a popular framework for building mobile applications. React Native allows for the development of cross-platform mobile applications using a single codebase.

    <br>

- **Backend:** Node.js <br>
    The backend of the app will be developed using Node.js, which is a popular backend development framework. Node.js is known for its scalability and speed, making it a great choice for developing high-performance backend systems.

    <br>

- **Database:** MongoDB <br>
    The app will use MongoDB as the database for storing user data. MongoDB is a NoSQL database that is known for its flexibility and scalability, making it a great choice for storing and managing large amounts of data.

    <br>

- **AI:** 
  - **TensorFlow** <br>
    The app will use TensorFlow, which is an open-source machine learning framework developed by Google. TensorFlow is known for its scalability and performance, making it a great choice for developing AI-powered applications.
  - **Python** <br>
    The app will use Python as the programming language for developing the AI component of the app. Python is a popular programming language for machine learning and AI applications, making it a great choice for developing the AI component of the app.

    <br>



## Conclusion

The Vet App is a mobile application designed to help pet owners ensure that their puppies receive the appropriate nutrition they need to thrive. With personalized nutritional recommendations powered by AI, the app provides an innovative and efficient solution to the challenges of pet nutrition. The app's features, including the food calculator, AI-powered analytics, and reminders, will help pet owners ensure that their puppies receive the best possible care and nutrition. The app's development will require the use of technologies such as React Native, Node.js, and MongoDB.
