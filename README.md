# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Architecture](#architecture)
5. [Structure](#structure)
6. [Running the tests](#running-the-tests)
7. [Deployment](#deployment)
8. [Dependencies](#dependencies)
9. [Task board](#task-board)
10. [Design](#design)
11. [API](#api)

# HelloWorld
Entain project that fetches list of next 5 races and displays to the user.

# Description
<p>
The project uses SwiftUI, Combine, XCTests and follows MVVM. Development was done on Xcode 15.4 with minimum deployment version set to 16.0.
</p>

# Getting started
<p>
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download/clone the project from the repository.<br>
3. Open the project file **EntainTask.xcodeproj** in Xcode.<br>
4. Wait for the package dependencies to complete fetching<br>
7. Run the active scheme.<br>
You should see the app running on the simulator/device of your choice and rendering the next 5 races post the API call<br>
</p>

# Architecture
* This project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* Model has data models required to map the API response into custom objects.
* View is responsible for displaying the fetched data on screen with additional functionalities like filter.
* ViewModel does the heavylifting of making the API call and transforming response data to suit the display.
* As this app involves a single screen, there are no navigations but can definitely be added with less effort.
  
# Structure 
* "Protocols": Contains the ```DataFetcher``` protocol which helps in injecting the API service as a dependency which further helps mocking and testing
* "View": This folder has the SwiftUI files that are responsible for the UI the user gets to see. There are multiple SwiftUI files which are components of the single screen split for readability and reusability.
* "ViewModel": This folder has the file NextRaceViewModel which is responsible for all the work behind the hood that makes an API call and then transforms/sorts data before feeding it to the views in the "View" folder.
* "Model": This folder has the Codable models which help us decode the json response from the server into meaningful model objects.
* "Constants": This folder hosts all the static strings, asset names and other constants.
* "Assets": This folder has the assets catalog file which hosts all icons, images and color catalogs. It also has a mock.json file which is used in tests.
* "Modules": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "Views" or "Models".
* "Resources": Non-code files that are used by the project. These can include images, audio files, video files, and other types of assets. 

# Running the tests
<p>This project can be tested using the built-in framework XCTest.<br>
To start testing the project, use Command+U which runs all the tests in the project. 
  For the functionality specific testing, please open the file EntainTaskTests and run the tests in that file</p>

# Deployment
Keep in mind that deploying an iOS app to the App Store requires having an Apple Developer account.

1. Click on the "Product" menu in Xcode and select "Archive." This will create an archive of your project.
2. Once the archive has been created, select it in the Organizer window and click on the "Validate" button to perform some preliminary tests on the app.
3. Once validation is complete, click on the "Distribute" button and select "Ad Hoc" or "App Store" distribution. 
This will create a signed IPA file that can be installed on iOS devices.
4. Follow the prompts in the distribution wizard to complete the distribution process.
5. Once the distribution is complete, you can use the IPA file to install the app on iOS devices

# Dependencies
[CocoaPods](https://cocoapods.org) is used as a dependency manager.
List of dependencies: 
* pod 'Alamofire' -> Networking library that ensures that the message reaches everyone in the world.
* pod 'AzikusAuthorization' -> Our library that serves for authorization. 
It is very important that <strong>it is maintained because it is also used by users outside the company</strong>.

# Workflow

* Reporting bugs:<br> 
If you come across any issues while using the HelloWorld, please report them by creating a new issue on the GitHub repository.

* Reporting bugs form: <br> 
```
App version: 2.12
iOS version: 16.1
Description: When I tap on the "Send" button, my friends don't receive message.
Steps to reproduce: Open "Messages" flow of the app, write down message, press "Send" button.
```

* Submitting pull requests: <br> 
If you have a bug fix or a new feature you'd like to add, please submit a pull request. Before submitting a pull request, 
please make sure that your changes are well-tested and that your code adheres to the Swift style guide.

* Improving documentation: <br> 
If you notice any errors or areas of improvement in the documentation, feel free to submit a pull request with your changes.

* Providing feedback:<br> 
If you have any feedback or suggestions for the HelloWorld project, please let us know by creating a new issue or by sending an email to the project maintainer.

# Task board
* Task management tool for our teams is [Jira](https://www.atlassian.com/software/jira)<br>
* Link to the board is [here](https://www.atlassian.com/software/jira)<br>

It is very important that the tasks are up to date so that the project managers could distribute the tasks as good as possible.<br>
Daily meetings are everyday at 9:45AM GMT. The planning of tasks is every 2 weeks, and the time for their execution is also 2 weeks, which includes testing.


# Design 
* Design tool for our teams is [Figma](https://www.figma.com)
* Link to the design is [here](https://www.figma.com) <br>
* All of the design is and must be only in one tool and currently it is Figma.<br>
* Colors in the Figma must have same name as colors in Xcode project.<br> 
* Basic UI elemnts are defined and can be found [here](https://www.figma.com)

# API 
* We are using a REST API
* List of API calls is [here](https://petstore.swagger.io/#/) 
* For HTTP networking we are using [Alamofire](https://github.com/Alamofire/Alamofire) 
