# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Architecture](#architecture)
4. [Structure](#structure)
5. [Running the tests](#running-the-tests)
6. [Dependencies](#dependencies)
7. [API](#api)
8. [Flow](#flow)
9. [Accessibility](#accessibility)

# Project Brief & Requirements
Entain project that fetches list of next 5 races and displays to the user.

# Description
<p>
The project uses SwiftUI, Combine, XCTests and follows MVVM. Development was done on Xcode 15.4 with minimum deployment version set to 16.0.
</p>

# Getting started
<p>
1. Make sure you have the Xcode version 14.0 or above installed on your computer.<br>
2. Download/clone the project from the repository.<br>
3. Open the project file <strong> EntainTask.xcodeproj </strong> in Xcode.<br>
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
* "Protocols": Contains the <strong>DataFetcher</strong> protocol which helps in injecting the API service as a dependency which further helps mocking and testing
* "View": This folder has the SwiftUI files that are responsible for the UI the user gets to see. There are multiple SwiftUI files which are components of the single screen split for readability and reusability.
* "ViewModel": This folder has the file NextRaceViewModel which is responsible for all the work behind the hood that makes an API call and then transforms/sorts data before feeding it to the views in the "View" folder.
* "Model": This folder has the Codable models which help us decode the json response from the server into meaningful model objects.
* "Constants": This folder hosts all the static strings, endpoint, asset names and other constants.
* "Assets": This folder has the assets catalog file which hosts all icons, images and color catalogs. It also has a <strong>mock.json</strong> file which is used in tests.
* "Modules": The source code files for a specific module. Files within a module folder are organized into subfolders, such as "Views" or "Models".
* "Resources": Non-code files that are used by the project. These can include images, audio files, video files, and other types of assets. 

# Running the tests
<p>This project can be tested using the built-in framework ```XCTest```.<br>
To start testing the project, use Command+U which runs all the tests in the project. For the functionality specific testing, please open the file ```EntainTaskTests``` and run the tests in that file</p>

# Dependencies
Swift Package Manager is used as a dependency manager.
List of dependencies: 
* SwiftLint: A tool to enforce Swift style and conventions based on GitHub's Swift Style Guide.

# Workflow
* Reporting bugs:<br> 
If you come across any issues while using this project/app, please report them by creating a new issue on the GitHub repository or contacting me directly @ dsaprajoth@gmail.com.

# API 
* The app uses the below GET endpoint to fetch the next 5 races
  ```
  https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=5
  ```

# Flow
1. App 
  

# Accessibility
1. App 
  

