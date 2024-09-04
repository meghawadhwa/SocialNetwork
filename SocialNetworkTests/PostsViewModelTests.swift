import XCTest
import RealmSwift
import RxSwift
@testable import SocialNetwork

class PostsViewModelTests: XCTestCase {
    
    var viewModel: PostsViewModel!
    var mockNetworkManager: MockNetworkManager!
    var disposeBag: DisposeBag!
    var realm: Realm!

    override func setUpWithError() throws {
        // Create a new Realm configuration with a unique in-memory identifier
        let config = Realm.Configuration(inMemoryIdentifier: UUID().uuidString)
        realm = try! Realm(configuration: config)
        
        // Set up the mock dependencies and ViewModel
        mockNetworkManager = MockNetworkManager()
        disposeBag = DisposeBag()
        viewModel = PostsViewModel(networkManager: mockNetworkManager, disposeBag: disposeBag, realm: realm)
    }

    override func tearDownWithError() throws {
        // Clean up the resources after each test
        viewModel = nil
        disposeBag = nil
        mockNetworkManager = nil
        
        // Clear the in-memory Realm
        try realm.write {
            realm.deleteAll()
        }
        realm = nil
    }
    
    /// Test that `fetchPosts` correctly updates the `posts` and `favoritePosts` arrays.
    func testFetchPosts() {
        // Given: Mock posts data
        let mockPosts = createMockPosts()
        mockNetworkManager.mockPosts = mockPosts
        // When: `fetchPosts` is called
        viewModel.fetchPosts()
        
        // Then: Posts should be correctly updated in ViewModel
        XCTAssertEqual(viewModel.posts.count, mockPosts.count, "Posts count should match mock data")
        XCTAssertEqual(viewModel.favoritePosts.count, 1, "Only one post should be marked as favorite")
    }
    
    /// Test that `toggleFavorite` correctly updates the favorite status of a post.
    func testToggleFavorite() {
        // Given: A post in local storage
        let post = createPost(id: 1, title: "Test Post", body: "This is a test post.", isFavorite: false)
        
        // When: The favorite status is toggled
        viewModel.toggleFavorite(post: post)
        
        // Then: The post's favorite status should be updated
        XCTAssertTrue(post.isFavorite, "Post should be marked as favorite")
    }
    
    // Helper method to create mock posts
    private func createMockPosts() -> [Post] {
        let post1 = createPost(id: 1, title: "Test Post 1", body: "Body 1", isFavorite: false)
        let post2 = createPost(id: 2, title: "Test Post 2", body: "Body 2", isFavorite: true)
        return [post1, post2]
    }
    
    // Helper method to create a Post object with specified properties
    private func createPost(id: Int, title: String, body: String, isFavorite: Bool) -> Post {
        let post = Post()
        post.id = id
        post.title = title
        post.body = body
        post.isFavorite = isFavorite
        try! realm.write {
            realm.add(post)
        }
        return post
    }
}
