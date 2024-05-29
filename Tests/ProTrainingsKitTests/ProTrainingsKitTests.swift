import XCTest
@testable import ProTrainingsKit

final class ProTrainingsKitTests: XCTestCase {
  let apiKey = "not-gonna-put-that-up-on-github"
  
  func testGetUsersReturnsSuccessful() async throws {
    
    let client = ProTrainingsClient(apiKey: apiKey)
    let users = await client.getUsers()
    
    assert(users!.isEmpty == false, "#getUsers didn't return anything")
  }
  
  func testGetUserReturnsSuccessful() async throws {
    let client = ProTrainingsClient(apiKey: apiKey)
    let users = await client.getUsers()
    if let users = users, let firstUser = users.first {
      let user = await client.getUser(firstUser.id)
      
      assert(user != nil, "#getUser(:id) didn't return anything")
    } else {
      assert(users != nil, "#getUser(:id) unable to retrieve current user list for testing purposes")
    }
  }
  
  func testGetUserReturnsNilForUnknownUserId() async throws {
    let client = ProTrainingsClient(apiKey: apiKey)
    let user = await client.getUser(1)
    
    assert(user == nil, "#getUser(:id) should return nil")
  }
  
  func testGetMagicLinkReturnsSuccessful() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    let link = await client.getMagicLink(login: "test.user@protrainings.com")
    
    assert(link != nil, "#getMagicLink(:login) didn't return anything")
  }
  
  func testGetMagicLinkReturnsNilForUnknownLogin() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    let link = await client.getMagicLink(login: "test@example.email")
    
    assert(link == nil, "#getMagicLink(:login) should return nil")
  }
  
  func testGetMagicLinkReturnsNilForBlankLoginName() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    let link = await client.getMagicLink(login: "")
    
    assert(link == nil, "#getMagicLink(:login) should return nil")
  }
  
  //  func testCreateUserReturnsSuccessful() async {
  //    let client = ProTrainingsClient(apiKey: apiKey)
  //    let user = try? await client.createUser(
  //      login: "test.user@protrainings.com",
  //      email: "test.user@protrainings.com",
  //      lastName: "Test",
  //      firstName: "User"
  //    )
  //
  //    assert(user != nil, "#createUser(:login) didn't return anything")
  //  }
  
  func testCreateUserThrowsErrorIfUserAlreadyExists() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    
    let (user, err) = await client.createUser(
      login: "test.user@protrainings.com",
      email: "test.user@protrainings.com",
      lastName: "Test",
      firstName: "User"
    )
    
    assert(err != nil, "#createUser() returns an error for user that exists")
    assert(user == nil, "#createUser() returns nil for user that exists")
  }
  
  func testCreateUserReturnsNilIfLoginIsBlank() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    let (user, _) = await client.createUser(
      login: "",
      email: "test.user@protrainings.com",
      lastName: "Test",
      firstName: "User"
    )
    
    assert(user == nil, "#createUser(:login) should have been nil")
  }
  
  func testCreateUserReturnsNilIfEmailIsBlank() async {
    let client = ProTrainingsClient(apiKey: apiKey)
    let (user, _) = await client.createUser(
      login: "test.user@protrainings.com",
      email: "",
      lastName: "Test",
      firstName: "User"
    )
    
    assert(user == nil, "#createUser(:login) returns an error")
  }
}
