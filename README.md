# wether
### A Flutter location based weather mobile app.

###### Wether is a fluid location based weather app that gives all relevant weather data of the users current location in beautiful and easy-to-understand graphics.

<p align="center">
  <img src="/assets/readme/weather_page.jpg" height="350" />
</p>

#### Screen cast: https://youtu.be/l4-rYDxob_o

| Platform | Available |
|--------------|--------------|
| Apple App Store| n/a (yet) |
| Google Play Store | [wether](https://play.google.com/store/apps/details?id=com.ewic.wether) |

This app was built with Flutter, and will eventually be available on both Android and iOS. Currently, wether is only available in the Google Play store.


This documentation will be organized through the two screens, the current weather screen, and the forecast screen; and additionally their similar functionalities will be discussed first. Both screens function very similarly with loading, error handling, and displaying the loaded data.


### Screen Similar functionality


Both of the screens are structured using a **FutureProvider**, provided (hehe) by [Riverpod](https://riverpod.dev/docs/getting_started) for Flutter. When the screen appears, their is a state watcher for the (current weather or forecast) provider. The state watcher has 3 states:

1. Loading
2. Error
3. Data

The future provider runs an async function which performs the API call for the weather/forecast data, and returns a Future value wrapped in one of the 3 states; so while it is being listened to in the widget tree, the appropriate Widget will appear. For both screens, the error and loading state look the same, and will be showed below.



being a page displaying the error message with a refresh button, and just a centered loading icon, respectively. However, both error and loading state have an alternative sub state.



## Loading screen state

###### Data is null

<img src="/assets/readme/loading_screen.jpg" height="350" />

While running the async function that the future provider contains, the state is set to loading. This is when the loading icon appears in the center of the screen while waiting for the state to change to data or error.



###### Data is not null

<img src="/assets/readme/weather_refreshing.jpg" height="350" />



However, if the data has already been loaded and the data screen is showing, when the user refreshes the page, the loading state is different. Instead of only being a centered loading icon, the loaded data screen will continue to show but the pull to refresh loading icon will continue to float above the screen.



## Error Screen state

###### Data is null

<img src="/assets/readme/error_page.jpg" height="350" />

When the async function fetching the data returns an error state, this triggers the error state to appear which has the relative error message, a recommendation for the user how to fix the error, and a refresh button to call the async function fetching the API data again.



###### Data is not null 
<p float="left">
  <img src="/assets/readme/weather_page_error.jpg" height="350" />
  <img src="/assets/readme/weather_page_error.jpg" height="350" />
</p>

Alternatively, if the data has already been previously loaded, the data page continues to be displayed through the loading state, then if the error state is triggered, a snack bar pop ups at the bottom of the screen displaying the error message. This way the user still continues to see the previous data even if internet or location connection has been lost.

## Current Weather Screen

<img src="/assets/readme/weather_page.jpg" height="350" />

`<widget tree of current weather>`

## Forecast Screen

<img src="/assets/readme/forecast_screen.jpg" height="350" />

`<widget tree of forecast>`
