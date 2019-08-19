# Trending Movies



*_Trending Movies is an app that let's you see the 20 most popular movies in the UK, and read a description of the movie's plot as well as see its average rating._*



### Approach taken

The app is built using a simple MVVM-C architecture, where the ViewModel for each screen is responsible for the business logic (such as communicating with the networking and storage layers), and Coordinators are implemented for navigation. The ViewControllers have been kept simple and is only responsible for presenting UI. 

The app persist the the movie objects and their related image data in a Core Data database, and will present the stored data if user is offline. 

Business logic is tested with unit testing, and UI is tested with XCUI UI testing. 

The app is built using a protocol oriented approach.



### Technologies used


-  [Swift 5](https://developer.apple.com/swift/)

- [The Movie DataBase API](https://www.themoviedb.org)


### How to test it



To test the app simply clone the repo, and build in latest version of Xcode. No need to run any third party library package managers. 

### Consious decisions

- Use of JSONSerialization instead of Codable as it was easier when working with Core Data.

### Known issues

- Only network related errors are handled.

### Future Improvements / Additions

- Implementation of pull to refresh with refresh controller.
- Implemet an "infinite scroll" table view and keep loading pages from API as user scrolls. 



### Screenshots



![alt text](https://i.imgur.com/Aunz3je.png)



### User stories:



```

As a user I can see the 20 most popular movies in UK for the current day in a list

```

```

As a user I can see details about a selected movie, such as release date and rating, in a new screen 

```

```

As a user, if I am offline, I can still see the last 20 movies that was loaded

```
```

As a user, if I'm offline and open the app for the first time, I will see an error message

```
