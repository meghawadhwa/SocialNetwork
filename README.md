# SocialNetwork App

## Overview

The **SocialNetwork** app is a simple social networking application that allows users to fetch posts, toggle their favorite status, and manage associated comments. This project uses **Realm** for local data storage and **RxSwift** for reactive programming.

## Features

- **Fetch Posts:** Retrieve posts from a network source and save them locally in a Realm database.
- **Toggle Favorite Status:** Mark or unmark posts as favorites, with the changes reflected both in the UI and in the database.
- **Comments Management:** Each post can have associated comments, which are also stored in the Realm database.

## Project Structure

- **Models:**
  - `Post`: Represents a social media post.
  - `Comment`: Represents a comment associated with a post.
- **ViewModels:**
  - `PostsViewModel`: Manages fetching, storing, and updating posts and their associated comments.

## Dependencies

- **RealmSwift:** A mobile database for storing data locally on the device.
- **RxSwift & RxCocoa:** Libraries for reactive programming, used for managing asynchronous events and UI bindings.
- **Combine:** A framework by Apple for handling asynchronous events by combining event-processing operators.

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/socialnetwork.git
   cd socialnetwork
2.  **Do the pod install** 
Install dependencies: Ensure you have CocoaPods installed. Then run:
    pod install
3. Open the generated .xcworkspace file in Xcode.
4. Build and run the app: Select a simulator or your connected device, and press Cmd + R to build and run the app.

## Dependency Versions

- **Xcode:** Xcode 15.4
- **Minimum iOS Version: ** iOS 14
- **Alamofire:** 5.9.1
- **Realm:** 10.53.0
- **COCOAPODS:** 1.15.2


## Code Explanation
Post Model

class Post: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var isFavorite: Bool = false
    @Persisted var comments: List<Comment>
}
Post: A Realm Object representing a post, containing fields like id, title, body, isFavorite, and a list of comments.

Comment Model

class Comment: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var email: String
    @Persisted var body: String
}

Comment: A Realm Object representing a comment, containing fields like id, name, email, and body.

PostsViewModel

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var favoritePosts: [Post] = []

    private let networkManager: NetworkManager
    private let realm: Realm
    private let disposeBag: DisposeBag

    init(networkManager: NetworkManager = NetworkManager.shared,
         disposeBag: DisposeBag = DisposeBag(),
         realm: Realm = try! Realm()) {
        self.realm = realm
        self.networkManager = networkManager
        self.disposeBag = disposeBag
        fetchLocalPosts()
    }
}
PostsViewModel: Manages the fetching, storing, and updating of posts and their comments. Uses Realm for local data storage and RxSwift for managing asynchronous events.

## Key Methods:
fetchPosts(): Fetches posts from the network and stores them in the local Realm database.
toggleFavorite(post:): Toggles the favorite status of a post.
fetchLocalPosts(): Retrieves posts from the local Realm database and updates the UI.

## Contributing:
1.Fork the repository
2.Create a new branch: git checkout -b feature-branch-name
3.Commit your changes: git commit -m 'Add some feature'
4.Push to the branch: git push origin feature-branch-name
5.Create a Pull Request


##License:
This project is licensed under the MIT License - see the LICENSE file for details.


