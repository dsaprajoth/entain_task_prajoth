# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Architecture](#architecture)
4. [Folder Structure](#folder-structure)
5. [Running the tests](#running-the-tests)
6. [Dependencies](#dependencies)
7. [API](#api)
8. [Flow](#flow)
9. [Accessibility](#accessibility)
10. [Scalability, Code Coverage & more](#scalability)

# Project Brief & Requirements
Entain project that displays a list of next 5 races to the user

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
  
# Folder Structure 
* "Network": Contains the <strong>NetworkManager</strong> class conforming to NetworkService protocol which helps in injecting the URLSession to help mocking and testing the network layer
* "View": This folder has the SwiftUI file NextRaceView which is the landing page of the app.
* "View/Subviews": This folder has the SwiftUI files that are components of the parent screen NextRaceView which are split for readability and reusability. <strong>ChipFilterView</strong> is used to build the filter chips above the list and <strong>RaceListItemView</strong> is used to build each item in the race list.
* "ViewModel": This folder houses the view models responsible for handling the state changes and making the view react to it. <strong>NextRaceViewModel</strong> handles data fetching and processing for the parent screen <strong>NextRaceView</strong> and <strong>RaceListItemViewModel</strong> handles <strong>RaceListItemView</strong> to display each race tile in the list with tasks such as maintaining the countdown timer and displaying race details.
* "Model": This folder has the Codable models which help us decode the json response from the server into meaningful model objects. It also contains an extension to the <strong>RaceSummary</strong> type with computed properties for easy display purposes.
* "Utils": This consists of
  - AppUtils which has utility methods to convert epoch time to human readable date, utility to format the countdown time to a desirable format and to fetch a mock json response for tests.
  - RaceUtils which contain race related utilities like categoryId constants, RaceType enum for identifying race types across the app.
  - View+Extensions which has a modifier helper that helps apply a modifier post unwrapping an optional value. I have used this to unwrap strings and apply accessibility.
* "Constants": This folder hosts all the static strings, endpoint, asset names and other constants.
* "Assets": This folder consists of string catalog, assets catalog file which hosts all icons, images and colors. It also has a <strong>mock.json</strong> file which is used in tests.

# Tests Folder Structure 
* "Utils": Contains an utility class for tests for functions like fetching a mock json response for tests.
* "NetworkLayerTests": This folder contains tests related to `NetworkManager`. It has a `MockURLProtocol` which helps in intercepting and mocking.
* "AppUtilTests": This folder contains app utility tests
* "NextRaceViewModelTests": This folder contains a file to test the `NextRaceViewModel` on various scenarios. It makes use of `MockNetworkManager` to mock the response in order to manipulate data and check for view model correctness.
* "RaceListItemTests": This folder contains a file to test the `RaceListItemViewModel` on various scenarios. It makes use of `RaceMockData` to mock the race object within the test to check for view model correctness.

# Running the tests
<p>This project is tested using the built-in framework ```XCTest```.<br>
To start testing the project, use Command+U which runs all the tests in the project. For the functionality specific testing, please open the files either `NextRaceViewModelTests`, `RaceListItemViewModelTests` or `AppUtilsTests` and run the tests individually or all the tests in that file</p>

# Dependencies
Swift Package Manager is used as a dependency manager.
List of dependencies: 
* SwiftLint: A tool to enforce Swift style and conventions based on GitHub's Swift Style Guide.

# Branching Strategies
`main` branch acts the final source of truth to the production app
`develop` branch will contain all work in progress "tested" code.
New tasks begin with branch names with the prefix `task/` followed by the name of the task which is easily readable and understandable by others. 
I have ensured all work in progress code of mine goes into sub branches and then into `develop`. 

# Workflow
* Reporting bugs:<br> 
If you come across any issues while using this project/app, please report them by creating a new issue on the GitHub repository or contacting me directly @ dsaprajoth@gmail.com.

# API 
* The app uses the below GET endpoint to fetch the next 10 races
  ```
  https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10
  ```

# Flow
1. App launches and renders `NextRaceView` screen
2. As the screen launches, the `NextRaceViewModel` is initialised and a call to method `fetchData()` is made to fetch next 10 races.
3. The `NextRaceViewModel` then processes the decoded data and
   - Filters out the races that are one minute past the advertised start
   - Sorts the races list by advertised start ascending
   - Triggers the view to display the relevant list of 5 races on screen
4. A global timer is started and keeps notifying both view models of the time interval. `RaceListItemViewModel` listens to the timer and updates the countdown string displayed. `NextRaceViewModel` listens to the timer and checks if any of the timer has about to go beyond a minute.
5. As it is notified, it calls the API again to fetch the new set of races as we have irrelavant list of races (race which is one minute past the advertised start)
6. The `NextRaceViewModel` process the new list again as in Step 3 and the flow continues.
  
# Accessibility
1. App is made accessible by making the layouts responding to font scale changes and custom voice over text to the user to get accurate information of the UI on screen.

# Scalability
1. New modules and features can be easily added to this app
2. NetworkManager is capable of handling any API calls to fetch data with also the flexibility to mock the responses specific to the feature.
3. Strings are maintained in a String catalog for easy localisation as and when the need arises to support multiple languages.
4. A shared TimerManager instance is used rather than each race having its own timer. This saves resources and helps keeping countdowns and related logic in sync.

# Code Coverage
- Currently the code coverage is <strong>93%</strong>

