# Food Social Network
![SwiftUI](https://img.shields.io/badge/SwiftUI-blue.svg?style=flat)
![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)
[![License](https://img.shields.io/cocoapods/l/AmwalPayment.svg?style=flat)](https://github.com/AmwalPayment/AmwalPayment-ios/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/ios.svg?)](https://github.com/AmwalPayment/AmwalPayment-ios#)

Social Media App for restaurant reviews.

## Screenshots
<p align="center">
  <img src="https://raw.githubusercontent.com/knight6700/SocialNetwork/develop/fastlane/screenshots/en-US/iPhone 13-login_framed.png" alt="Login Screen" width="250"/> 
  <img src="https://raw.githubusercontent.com/knight6700/SocialNetwork/develop/fastlane/screenshots/en-US/iPhone 14-posts_framed.png" alt="Posts Screen" width="250"/> 
</p>

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Libraries](#libraries)
- [Dependencies](#dependencies)

## Introduction
The Social Media app allows users to submit restaurant reviews within the app.

## Features
 - Login: Handle login with username and password with validation 
 - Posts List: Display user images and post images
 - Search Posts
 - Dark Mode Support

## Libraries
 - **Shared UI**: Provides shared UI elements such as:
   - Primary Text Field and Secure Text Field with validation and text formatting
   - Primary Button for actions, with enable/disable state depending on the view's form
   - Custom Tab Bar
   - Search Bar View: Custom search bar to manage search state and clear text
   - Navigation Bar Style: Customize navigation bar styles, including title, trailing view, and back button
   - Loading View

 - **Horizon Storage**: Manages local storage for users, including UserDefaults, Keychain, and CoreData.

 - **Horizon Network**: Handles network requests asynchronously using async and await.

 - **Shared Models**: Provides shared models for requests and responses for API communication.

## Dependencies
This project uses a dependency management library inspired by SwiftUI's "environment." For more information, please visit [swift-dependencies](https://github.com/pointfreeco/swift-dependencies).
