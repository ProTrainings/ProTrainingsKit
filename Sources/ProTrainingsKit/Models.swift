//
//  File.swift
//  
//
//  Created by Tim Bugai on 5/8/24.
//

import Foundation

public struct Certification: Codable {
  public var id: UInt
  public var name: String
  public var certNumber: String?
  public var issueDate: String?
  public var expirationDate: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case certNumber = "cert_number"
    case issueDate = "issue_date"
    case expirationDate = "expiration_date"
  }
}

public struct User: Codable {
  public var id: UInt
  public var type: String
  public var firstName: String
  public var lastName: String
  public var email: String?
  public var login: String
  public var phone: String?
  public var createdAt: String
  public var currentCertifications: [Certification]?
  public var lastActive: String?
  public var link: String?
  public var magicLink: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case type
    case firstName = "first_name"
    case lastName = "last_name"
    case email
    case phone
    case login
    case createdAt = "created_at"
    case currentCertifications = "current_certifications"
    case lastActive = "last_active"
    case link
    case magicLink = "magic_link"
  }
}

struct MagicLink: Codable {
  public var link: String?
}

struct Metadata: Codable {
  var page: UInt?
  var perPage: UInt?
  var total: UInt?
  var prevPage: String?
  var nextPage: String?
  
  enum CodingKeys: String, CodingKey {
    case page
    case perPage = "per_page"
    case total
    case prevPage = "prev_page"
    case nextPage = "next_page"
  }
}


// Response Structures

struct UsersResult: Codable {
  var message: String
  var data: [User]?
  var metadata: Metadata?
}

struct UserResult: Codable {
  var message: String
  var data: User?
}

struct MagicLinkResult: Codable {
  var message: String
  var data: MagicLink?
}


// Request Structures

struct MagicLinkRequest: Codable {
  var login: String
}

struct CreateUserRequest: Codable {
  var login: String
  var email: String
  var firstName: String
  var lastName: String
  
  enum CodingKeys: String, CodingKey {
    case login
    case email
    case firstName = "first_name"
    case lastName = "last_name"
  }
}
