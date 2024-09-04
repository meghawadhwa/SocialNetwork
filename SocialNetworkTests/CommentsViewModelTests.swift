import XCTest
import RealmSwift
import RxSwift
@testable import SocialNetwork

class CommentsViewModelTests: XCTestCase {
    
    var viewModel: CommentsViewModel!
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
        viewModel = CommentsViewModel(networkManager: mockNetworkManager, disposeBag: disposeBag, realm: realm)
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
    func testFetchComments() {
        // Given: Mock posts data
        let mockComments = createMockComments()
        mockNetworkManager.mockComments = mockComments
        viewModel.post = createPost(id: 99, title: "abc", body: "abc body", isFavorite: false)

        // When: `fetchComments` is called
        viewModel.fetchComments()
        
        // Then: Posts should be correctly updated in ViewModel
        XCTAssertEqual(viewModel.comments.count, mockComments.count, "Comments count should match mock data")
    }
        
    // Helper method to create mock posts
    private func createMockComments() -> [Comment] {
        let comment1 = createComment(id: 100, name: "ABC User", email:"abc@gmail.com",  body: "Body 1")
        let comment2 = createComment(id: 101, name: "ABC User 2", email:"abc2@gmail.com",  body: "Body 2")
        return [comment1, comment2]
    }
    
    // Helper method to create a Post object with specified properties
    private func createComment(id: Int, name: String, email: String, body: String) -> Comment {
        let comment = Comment()
        comment.id = id
        comment.name = name
        comment.email = email
        comment.body = body
        
        try! realm.write {
            realm.add(comment)
        }
        return comment
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
