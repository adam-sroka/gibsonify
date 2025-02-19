# Changelog
All notable changes to this project will be documented in this file.

## 1.0.0 (2022-01-30)

### Feat

- **collection**: add text to new food item button
- add app icon
- minor collection features
- add comments to collection
- add interview outcome
- add interview end time, finish collection page
- add recall day to collection and api
- add sensitization date, remove sensitization status
- change buttons and time periods display
- export saved data via email
- implement data download
- integrate data layer, collections, recipes
- integrate recipe to collection
- add local storage of recipes
- add data layer and multiple collections
- **recipe**: implement recipe types and probes
- add generated json methods for recipes list
- **recipe**: change to slidable delete buttons
- add multiple collections functionality
- add home bloc
- **gibsonify_api**: remove loadform method
- **gibsonify_repository**: remove loadform functionality
- **gibsonify_repository**: add loading multiple forms and form deletion functionality
- **gibsonify_api**: add functionality to delete a form
- **gibsonify_api**: add multiple gibsons forms saving functionality
- add manual json serialization to recipe models
- **collection**: add saving gibsons form functionality to passes
- **add-loading-and-creating-functionality-to-collections-screen**: 
- **collection**: add data layer functionality to bloc
- add bloc local storage data layer
- add manual json serialization to collection models
- **recipe**: implement recipe probes
- **recipe**: implement recipe deletion
- **recipe**: implement ingredient deletion
- **recipe**: implement UUID recipe numbers
- **recipe**: implement non-standard recipes
- **gibsonify_api**: add pretty string representation of gibsons form
- **collection**: add basic functionality of all gibsons method passes
- **collection**: make any change to a food item result in unconfirming it
- **recipe**: add preliminary recipe implementation
- **recipe**: add logic for changing recipe/ingredient status
- **recipe**: add navigation logic to enable recipe/ingredient editing
- **collection**: add fourth pass ui and underlying bloc
- **collection**: add third pass ui and underlying bloc
- add collection third pass help page and underlying navigation
- **collection**: add interview start time field, picker, and logic to sensitization
- **collection**: add bloc and ui for deleting food items
- **collection**: change second pass wording for increased clarity
- add date picker to sensitization with formatting using intl
- **collection**: add second pass ui and bloc
- add second pass help page to collection and navigation
- **collection**: add dropdown form field for choosing food time period
- add ingredient form
- add first pass help page to collection and to navigation
- **recipe**: add rudimentary recipe form
- add demo display of collection on home page
- add sensitization help page to collection with routing in navigation
- **collection**: add sensitization input demo
- add system based dark mode
- **collection**: add blocbuilders with demo display of current collection state to third and fourth passes
- **collection**: add bloc, model and update collection page and screens with demo
- **collection**: add sensitization, first, second, third, and fourth pass screens
- add sync screen
- add new pages using feature-driven structure and update navigation
- add app screens and navigation

### Fix

- recipes not saving when created from collection
- **collection**: first pass food item card typo
- **collection**: first pass food item card typo
- recipes json method bug
- pubspec confilct and merge dev branch
- duplicate key error in collections screen
- **collection**: sensitization screen bottom overflowed error
- **recipe**: fix renderflex error and bug with dropdown selection not showing
- **recipe**: fix bug with probelist keys updating too frequently
- **recipe**: fix issue with Bloc not updating for ingredient changes
- **recipe**: implement PR comments
- **recipe**: Fixed bug that blocked new recipe state managementand refactored old code
- **collection**: make dropdown items consistently display selected value
- **collection**: add missing space to sensitization help page
- **collection**: add interview date to get props method of equatable to add it to state
- correct app name to start with a capital letter
- **home_page**: change bottom navigation bar type to fixed to allow more than three items
- **collection_page**: rename appbar and body text to new collection instead of recipe

### Refactor

- **gibsonify_api**: rearrange code order for readability
- move recipe models to gibsonify api
- **gibsonify_api**: remove debugging print statements
- move collection models into repository and api
- make one class encompassing all fields of gibsons form
- **collection**: move fourth pass food card to its own file
- **collection**: move third pass food card dropdown menus to lists
- **collection**: move third pass food card to its own file
- **collection**: move second pass food card dropdown menus to lists
- **collection**: move second pass food card to its own file
- **collection**: move first pass time period items to a list
- **collection**: make a standalone file and widget for first pass food item cards
- **recipe**: rename ingredient screen to ingredient form
- **collection**: simplify household id validation check
- **collection**: change wording of sensitization date input error text
- **collection**: change controller based date text updating to key based
- **recipe**: remove unused focus/unfocus node logic
- **collection**: remove form field focus ui and logic
- **collection**: move first pass blank dropdown item to beginning
- **collection**: move sensitization screen help button to app bar
- **collection**: remove old logic related to food items
- change to feature-driven app architecture using flutter_bloc
- **collection**: remove equatable as a base class for collection and rename to gibsonsform
- **collection**: change sensitization screen form to formz inputs, add input models and demos
- **collection**: change sensitization, first_pass and second_pass screens to stateless widgets
- move app from main to separate file
- start a fresh flutter project
