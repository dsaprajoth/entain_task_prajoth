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
Entain project that displays a list of next 5 races to the user always with no race being older than a minute from the advertised start date.

# Description
<p>
The project uses SwiftUI, Combine, XCTests and follows MVVM. Development was done on Xcode 15.4 with minimum deployment version set to 16.0.
</p>

<strong>App Screenshots & Videos</strong>
| Next 5 Races | Filter Applied (Harness) | Filter Applied (Harness & Greyhounr) | Negative counter upto -60s |
| --- | --- | --- | --- |
| ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 14 09 45](https://github.com/user-attachments/assets/fd8e1792-b01f-4474-893f-5fa7764f034c) | ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 14 09 49](https://github.com/user-attachments/assets/41da2a0c-c986-4600-ab65-12aa277daa3f) | ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 14 09 52](https://github.com/user-attachments/assets/5ba1c87d-9a6b-4c7b-8e24-cc63f39272f2) | ![Simulator Screenshot - iPhone 15 Pro - 2024-12-16 at 14 10 03](https://github.com/user-attachments/assets/6040ed0e-aea2-4c32-89fd-39b3e8e51cc5)

<strong>Refresh when a race time reaches beyond a minute from advertised start</strong>

https://github.com/user-attachments/assets/4e18da84-88e3-4e11-b9e2-97b935bc8ea7

<strong>Refresh when a race time reaches beyond a minute from advertised start - With Filters Applied</strong>

https://github.com/user-attachments/assets/c2974375-e81a-4822-9528-45b2b7358e64


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
![diag](https://github.com/user-attachments/assets/4b55ec27-aca4-4fd8-8b11-daeb6cb99b50)

* This project is implemented using the <strong>Model-View-ViewModel (MVVM)</strong> architecture pattern.
* Model has data models required to map the API response into custom objects.
* View is responsible for displaying the fetched data on screen with additional functionalities like filter.
* ViewModel does the heavylifting of making the API call and transforming response data to suit the display.
* As this app involves a single screen, there are no navigations but can definitely be added with less effort.
  
# Folder Structure 
* `Network/`
  - `NetworkManager.swift`: Class conforming to NetworkService protocol which helps in injecting the URLSession to help mocking and testing the network layer
* `View/`
  - `NextRaceView.swift`: NextRaceView is the landing/parent view of the app
* `View/Subviews/`: This folder has the SwiftUI files that are components of the parent screen NextRaceView which are split for readability and reusability
  - `ChipFilterView.swift`: <strong>`ChipFilterView`</strong> is used to build the filter chips above the list 
  - `RaceListItemView.swift`: <strong>`RaceListItemView`</strong> is used to build each item in the race list
* `ViewModel/`: This folder houses the view models responsible for handling the state changes and making the view react to it.
  - `NextRaceViewModel.swift`: <strong>`NextRaceViewModel`</strong> handles data fetching and processing for the parent screen <strong>NextRaceView</strong>
  - `RaceListItemViewModel.swift`: <strong>`RaceListItemViewModel`</strong> handles <strong>RaceListItemView</strong> to display each race tile in the list with tasks such as maintaining the countdown timer and displaying race details.
  - `TimerManager.swift`: <strong>`TimerManager`</strong> manages the Singleton `TimerManager` instance to ensure all countdowns and data reloads are in sync.
* `Model/`: This folder has the Codable models which help us decode the json response from the server into meaningful model objects.
  - `NextRaceModel.swift`: `NextRaceModel` is the main model that decodes the API response. It also contains an extension to the <strong>RaceSummary</strong> type with computed properties for easy display purposes.
* `Utils/`: 
  - `AppUtils.swift`: `AppUtils` which has utility methods to convert epoch time to human readable date, utility to format the countdown time to a desirable format and to fetch a mock json response for tests.
  - `RaceUtils.swift`: `RaceUtils` which contain race related utilities like categoryId constants, RaceType enum for identifying race types across the app.
  - `View+Extensions.swift`: `View+Extensions` which has a modifier helper that helps apply a modifier post unwrapping an optional value. I have used this to unwrap strings and apply accessibility.
* `Constants/`:
  - `APIConstants.swift`: `APIConstants` `struct` has the endpoint
  - `FontConstants.swift`: `Font` extension to manages custom fonts
  - `StringConstants.swift`: String constants
  - `AssetConstants.swift`: Asset name references
  - `AccessibilityConstants.swift`: Accessibility identifiers and labels
  - `ColorConstants.swift`: Color name references from the asset catalog.
* `Assets/`:
  - `Localizable.xcstrings`: File containing localizable strings. Makes it very easy to add new languages.
  - `Assets.xcassets`: Contains icons, images and color catalogs.
  - `mock.json`: Mock response for testing purposes

# Tests Folder Structure 
* `TimerManagerTests/`
  - `TimerManagerTests.swift`: Tests related to `TimeManager` to ensure timer correctness.  
* `Utils/`
  - `TestUtils.swift`: Contains an util to fetch mock json and map it to model
* `NetworkLayerTests/`
  - `MockURLSessionProtocol.swift`: To intercept and mock request
  - `MockRaceModel.swift`: A mock model to simulate race object
  - `NetworkManagerTests.swift`: `NetworkManager` related tests reside here
* `AppUtilTests/`
  - `AppUtilTests.swift`: Testing util methods mainly epoch conversion related
* `NextRaceViewModelTests/`
  - `MockNetworkManager.swift`: To mock the response in order to manipulate data and check for view model correctness
  - `NextRaceViewModelTests.swift`: Tests to check the main view model correctness
* `RaceListItemTests/`
  - `RaceListItemViewModelTests.swift`: Testing the list item view model
  - `RaceMockData.swift`: to mock the race object within the test to check for view model correctness.
* `EntainTaskUITests/`
  - `RaceistViewUITests.swift`: Contains UI Test for the main screen which checks for the list availability and also checks for list item elements.

# Running the tests
<p>This project is tested using the built-in framework `XCTest`.<br>
To start testing the project, use Command+U which runs all the tests in the project. For the functionality specific testing, please open the files either `NextRaceViewModelTests`, `RaceListItemViewModelTests` or `AppUtilsTests` and run the tests individually or all the tests in that file</p>
An UI Test is also added to verify that the race list is visible along with it's UI labels. Please refer `RaceistViewUITests.swift`.

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

