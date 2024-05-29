// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@available(iOS 15, macOS 12.0, *)
public class ProTrainingsClient {
  var apiKey: String
  
  public init(apiKey: String) {
    self.apiKey = apiKey
  }
  
  public func getUsers() async -> [User]? {
    do {
      let url = URL(string: "https://www.protrainings.com/api/v1/users")!
      var request = URLRequest(url: url)
      request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      if let statusCode = response.getStatusCode(), statusCode == 200 {
        let results = try JSONDecoder().decode(UsersResult.self, from: data)
        return results.data
      }
    } catch {
      return nil
    }
    
    return nil
  }
  
  public func getUser(_ id: UInt) async -> User? {
    do {
      let url = URL(string: "https://www.protrainings.com/api/v1/users/\(id)")!
      var request = URLRequest(url: url)
      request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
      let (data, response) = try await URLSession.shared.data(for: request)
      
      if let statusCode = response.getStatusCode(), statusCode == 200 {
        let results = try JSONDecoder().decode(UserResult.self, from: data)
        return results.data
      }
    } catch {
      return nil
    }
    
    return nil
  }
  
  public func getMagicLink(login: String) async -> String? {
    guard login.isEmpty == false else {
      return nil
    }
    
    do {
      let magicLinkRequest = MagicLinkRequest(login: login)
      let url = URL(string: "https://www.protrainings.com/api/v1/magic_link")!
      var request = URLRequest(url: url)
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
      request.httpMethod = "POST"
      request.httpBody = try JSONEncoder().encode(magicLinkRequest)
      
      let (data, response) = try await URLSession.shared.data(for: request)
      
      if let statusCode = response.getStatusCode(), statusCode >= 200, statusCode < 300 {
        let magicLinkResult = try JSONDecoder().decode(MagicLinkResult.self, from: data)
        if let magicLink = magicLinkResult.data {
          return magicLink.link
        }
      }
    } catch {
      return nil
    }
    
    return nil
  }
  
  public func createUser(login: String, email: String, lastName: String, firstName: String) async -> (User?, ProTrainingsAPIError?) {
    guard login.isEmpty == false && email.isEmpty == false else {
      return (nil, ProTrainingsAPIError.invalidData)
    }
    
    let createUserRequest = CreateUserRequest(login: login, email: email, firstName: firstName, lastName: lastName)
    let url = URL(string: "https://www.protrainings.com/api/v1/users")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    
    do {
      request.httpBody = try JSONEncoder().encode(createUserRequest)
    } catch {
      return (nil, ProTrainingsAPIError.jsonEncoding)
    }
    
    var data: Data
    var response: URLResponse
    
    do {
      (data, response) = try await URLSession.shared.data(for: request)
    } catch {
      return (nil, ProTrainingsAPIError.unknown(code: -1))
    }
    
    if let statusCode = response.getStatusCode() {
      print("Status Code: \(statusCode)")
      switch(statusCode) {
      case 200:
        var createUserResult: UserResult
        do {
          createUserResult = try JSONDecoder().decode(UserResult.self, from: data)
        } catch {
          return (nil, ProTrainingsAPIError.jsonDecoding)
        }
        
        if let user = createUserResult.data {
          return (user, nil)
        }
      case 409:
        return(nil, ProTrainingsAPIError.userAlreadyExists)
      case 422:
        return(nil, ProTrainingsAPIError.invalidData)
      default:
        return (nil, ProTrainingsAPIError.unknown(code: -2))
      }
    }
    return (nil, ProTrainingsAPIError.unknown(code: -3))
  }
}


