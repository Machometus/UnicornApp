<h3 align="center">
  <a href="https://github.com/Machometus/UnicornApp" target="_blank">
    <img src="https://github.com/Machometus/UnicornApp/blob/main/UnicornApp/Documentation.docc/Resources/logo.png?raw=true" alt="MVVMCombine Logo" />
  </a>
</h3>

# UnicornApp

Unicorn Haven: Where Magic Meets Management!

The Unicorn app is a vibrant and interactive tool that allows unicorn enthusiasts to maintain a dynamic registry of these mystical creatures. Users are greeted with a list of unicorns, each represented with unique details and the ability to navigate to further information or to perform edits. Adding new unicorns to the collection is facilitated through a clear and simple interface, enabling users to enrich their collection with ease.

At the heart of the app's operation is the Composable Architecture which underpins a robust and predictable state management system. This architecture streamlines the task of keeping the UI in sync with the backend, providing a seamless experience even during data-intensive operations such as fetching updates or saving new information.

In essence, the Unicorn app is not just a repo but an experience, designed to captivate and facilitate users in their journey through a magical realm of unicorns.

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Features](#features)
* [Getting Started](#getting-started)
    * [Requirements](#requirements)
* [Installation and Setup](#installation-and-setup)
    * [Swift Package Manager Integration](#swift-package-manager-integration)
    * [Data Management Configuration](#data-management-configuration)
    * [API Configuration](#api-configuration)
* [How It Works](#how-it-works)
    * [Architecture](#architecture)
    * [Learn More](#learn-more)
* [Basic Usage](#basic-usage)
    * [Feature Construction](#feature-construction)
    * [Testing](#testing)
    * [Snapshot Testing Integration](#snapshot-testing-integration)
* [Demo](#demo)
    * [Store Hierarchy](#store-hierarchy)
    * [Appearance](#appearance)
* [Documentation](#documentation)
* [To Do](#to-do)
* [Credits](#credits)
* [License](#license)
* [Author](#author)

<!-- FEATURES -->
## Features

The app used a robust architecture designed for scalable and maintainable development. Here are some further details about the app's features and how they're implemented:

- **Unicorn Management**: Easily add, modify, and remove unicorns with intricate attributes.
- **Data Handling**: Manage unicorn data both remotely or locally with SwiftData.
- **User Experience**: Provide loading states and prompt alerts for any operational issues.
- **Theming and Appearance**: Dynamic, user-friendly theming with a responsive design.
- **Localization**: Supports English, Arabic (with RTL layout), and German languages.
- **State Management**: Efficiently separates UI state from business logic.
- **Modular Components**: Use actions for predictable state changes and handle side effects.
- **Navigation**: Access detailed views for individual unicorn management.
- **Data Structures**: Organize unicorns using unique identifiers for streamlined updates.
- **Accessibility**: Prioritizes inclusive design, ensuring usability for individuals with varying abilities.
- **Documentation**: The project is thoroughly documented, and documentation can be easily generated using Apple's Docc.

In essence, the app serves as a comprehensive platform for users who are interested in maintaining a virtual stable of unicorns, providing them with the tools needed to manage their collection efficiently and with a pleasant user experience. It's a testament to the power of modern architecture patterns in building complex UIs in a maintainable way.

<!-- GETTING STARTED -->
## Getting Started

<!-- REQUIREMENTS -->
### Requirements

- iOS 17.0+ / macOS 14.1+ / tvOS 17.0+ / watchOS 10.0+
- Xcode 15.0+
- Swift 5.9+

<!-- INSTALLATION -->
## Installation and Setup

<!-- SPM -->
### **Swift Package Manager Integration**

The project is pre-configured to leverage Swift Package Manager for dependency resolution. Upon initial project load, the following package dependencies will automatically be fetched and integrated:

- `swift-snapshot-testing` at version `1.14.2`, which provides snapshot testing capabilities for Swift applications.
- `swift-composable-architecture` at version `1.2.0`, a framework that facilitates the implementation of the composable architecture pattern in Swift apps.

<!-- SWIFTDATA -->
### **Data Management Configuration**

This project offers flexible data management options to cater to different development and testing scenarios:

- **Local Data Storage with SwiftData:** To run the project using local data storage capabilities provided by SwiftData, add the `SWIFTDATA` flag to both the `UnicornApp` and `UnicornAppTests` targets. This can be set in `Build Settings` -> `Active Compilation Conditions`.

- **CRUD Backend Integration:** For development or testing with a live backend, ensure that the `SWIFTDATA` flag is removed from the aforementioned targets. This configures the application to interact with the remote CRUD backend server.

Switching between these two modes is easily achieved by toggling the presence of the `SWIFTDATA` flag in the project's build settings as described.

<!-- CRUDCRUD -->
### **API Configuration**

To get the application up and running with the backend services:

1. Go to [crudcrud](https://crudcrud.com/) to obtain your unique API endpoint secret.
2. In your project, navigate to the `URLClient` struct.
3. Find the `secret` property or method, and set its value to your unique secret obtained from crudcrud.

This step is crucial for the proper operation of the backend API.

<!-- HOW IT WORKS -->
## How It Works

<!-- ARCHITECTURE -->
### **Architecture**

The Composable Architecture provides a few core tools that can be used to build applications of varying purpose and 
complexity. It provides compelling stories that you can follow to solve many problems you encounter 
day-to-day when building applications, such as:

* **State management**
  <br> How to manage the state of your application using simple value types, and share state across 
  many screens so that mutations in one screen can be immediately observed in another screen.

* **Composition**
  <br> How to break down large features into smaller components that can be extracted to their own, 
  isolated modules and be easily glued back together to form the feature.

* **Side effects**
  <br> How to let certain parts of the application talk to the outside world in the most testable 
  and understandable way possible.

* **Testing**
  <br> How to not only test a feature built in the architecture, but also write integration tests 
  for features that have been composed of many parts, and write end-to-end tests to understand how 
  side effects influence your application. This allows you to make strong guarantees that your 
  business logic is running in the way you expect.

* **Ergonomics**
  <br> How to accomplish all of the above in a simple API with as few concepts and moving parts as 
  possible.

### **Learn More**

The Composable Architecture was designed over the course of many episodes on 
[Point-Free](https://www.pointfree.co/), a video series exploring functional programming and the Swift language, 
hosted by [Brandon Williams](https://twitter.com/mbrandonw) and [Stephen Celis](https://twitter.com/stephencelis).

You can watch all of the episodes [here](https://www.pointfree.co/collections/composable-architecture), as well as a dedicated, [multipart tour](https://www.pointfree.co/collections/tours/composable-architecture-1-0) of the architecture from scratch.

<h3 align="center">
    <img src="https://github.com/Machometus/UnicornApp/blob/main/UnicornApp/Documentation.docc/Resources/tca_diagram.png?raw=true" alt="The composable Architecture Diagram" />
</h3>

<!-- Basic-Usage -->
## Basic Usage

<!-- Feature-Construction -->
### Feature Construction

> **Note**
> For a step-by-step interactive tutorial, be sure to check out [Meet the Composable
> Architecture](https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/meetcomposablearchitecture).

To build a feature using the Composable Architecture you define some types and values that model 
your domain:

* **State**: A type that describes the data your feature needs to perform its logic and render its 
UI.
* **Action**: A type that represents all of the actions that can happen in your feature, such as 
user actions, notifications, event sources and more.
* **Reducer**: A function that describes how to evolve the current state of the app to the next 
state given an action. The reducer is also responsible for returning any effects that should be 
run, such as API requests, which can be done by returning an `Effect` value.
* **Store**: The runtime that actually drives your feature. You send all user actions to the store 
so that the store can run the reducer and effects, and you can observe state changes in the store 
so that you can update UI.

<!-- Testing -->
### Testing

For testing, TestStore is employed to simulate user interactions and validate state changes within the app. It allows developers to verify the functionality of user interface actions, like incrementing or decrementing a value, by asserting expected state transformations after each action. Additionally, it can test asynchronous behaviors, such as checking for updates following network requests, ensuring that state changes, like alerts with fetched data, occur as intended.

<!-- Snapshot-Testing-Integration -->
### Snapshot Testing Integration

The [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) library offers a robust framework for UI snapshot testing within Swift applications. It is engineered to capture and compare snapshots of UI states, facilitating a comprehensive visual regression test suite. This tool aids developers in meticulously asserting the integrity of the user interface by detecting alterations that occur due to code changes. With this library, developers can ensure UI consistency and prevent unintended modifications from progressing through the deployment pipeline, thereby enhancing the quality assurance processes. Integrating this library via Swift Package Manager streamlines the addition of snapshot tests into the continuous integration workflow.

> **Important**
> To ensure the success of your snapshot tests, please execute them on an iPhone 15 Pro using the English language setting and the citrusGlow theme. If you choose to use different settings, it will be necessary to update the snapshots to align with your chosen configurations.

<!-- DEMO -->
## Demo

UnicornApp is a vibrant demo that highlights the robust capabilities of the composable architecture, offering straightforward addition, editing, and deletion of unicorns, orchestrated by reducers for seamless navigation and data management.

<p align="center">
<img src="https://github.com/Machometus/UnicornApp/blob/main/UnicornApp/Documentation.docc/Resources/sample.gif?raw=true" alt="MyUnicornGiF" width="300"/>
</p>

<!-- STORE-HIERARCHY -->
### Store Hierarchy

The following diagram illustrates store hierarchy managing state/reducer within the sample demo:

<h3 align="center">
    <img src="https://github.com/Machometus/UnicornApp/blob/main/UnicornApp/Documentation.docc/Resources/hierarchy.png?raw=true" alt="Coordinator Hierarchy" />
</h3>

<!-- Appearance -->
### Appearance

The UnicornApp architecture is thoughtfully designed to offer users an immersive experience with customizable visual themes.

Main App Structure: The app's backbone and primary functionality are encapsulated within UnicornApp.
Central View: The main interface that the user interacts with is known as the RootView.

* Theme Selection: The app's appearance is chiefly determined by the theme parameter. By default, the theme is set to citrusGlow.
* Theme Application: The RootView incorporates a dedicated function, .appearance, tailored for theme selection. When a theme is chosen, it becomes the overarching visual motif of the app.
* Launch Screen: The Launch Screen Background color can be set from Info.plist file.

> **Note**
> To tweak the global accent color, one doesn't need to modify the app's code. This can be accomplished by visiting the project's settings in Xcode and altering the "Global Accent Color Name".

<!-- documentationO -->
## Documentation

### Documentation Process
Ensuring clarity and ease of access for all users and developers, the project has been meticulously documented. This comprehensive documentation covers every facet of the application, providing clear instructions, code explanations, and usage scenarios.

### Building the Documentation:

1. Inline Documentation: Descriptive comments and markups have been employed throughout the codebase, detailing classes, methods, and other pivotal components.
1. Documentation Catalogs: We've curated catalogs that explain overarching concepts, user guides, and tutorials for better organization.
1. Generating Documentation:
    - In Xcode, select Product from the top menu.
    - Choose Build Documentation.
    - Xcode compiles the documentation based on provided comments and catalogs.
1. Hosting Online:
    - Post-generation, the documentation archive is ready for online hosting.
    - Extract the contents and host on your preferred platform, ensuring public accessibility.

> **Important**
> It's crucial to keep the documentation updated with every major code change or feature addition. This ensures that the documentation remains a reliable resource for both current and future reference.

By harnessing the power of DocC and maintaining a commitment to thorough documentation, the project ensures that any stakeholder can easily understand, modify, or extend the application as needed.

<!-- TO DO -->
## To Do

- [ ] Enhance exception handling for improved application stability.

- [ ] Extend unit testing coverage for reducers to safeguard application logic.

- [ ] Incorporate snapshot tests for accessibility and to ensure UI compatibility on small devices.

- [ ] Develop unit tests that remain reliable across various user settings.

- [ ] Redesign theming by adopting the reducer pattern, as discussed in [swift-composable-architecture #1178](https://github.com/pointfreeco/swift-composable-architecture/discussions/1178).

- [ ] Apply composable architecture patterns to smaller components, like `UnicornForm`.

- [ ] Transition from `NavigationView` to `NavigationStack` for navigation handling.

- [ ] Use `NavigationLink` with proper state management for item views.

- [ ] Implement `@PresentationState` and `@PresentationAction` for sheet presentations.

- [ ] Create a wide array of SwiftUI previews to test different UI states and scenarios.

- [ ] Host the project documentation on GitHub Pages or a similar cloud document hosting service.

<!-- Credits -->
## Credits

I would like to extend my gratitude to:

- The team at [Point-Free](https://www.pointfree.co/) for developing the [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture), which has been instrumental in structuring this application with a focus on state management and composability.
- [Point-Free](https://www.pointfree.co/) once again for their [Swift Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing) library, which has been invaluable for ensuring UI consistency through snapshot tests.
- [crudcrud](https://crudcrud.com/), for using their wonderful service, to build dynamic CRUD operations with no back-end code!

<!-- LICENSE -->
## License

UnicornApp is released under the MIT license. [See LICENSE](https://github.com/Machometus/UnicornApp/blob/main/LICENSE) for details.

<!-- AUTHOR -->
## Author

Mohamed Salem

- [LinkedIn](https://eg.linkedin.com/in/machometus)
- [Xing](https://www.xing.com/profile/Mohamed_Salem19/cv)
- [Twitter](https://twitter.com/MSalemsson)
