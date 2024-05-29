//
//  File.swift
//  
//
//  Created by Tim Bugai on 5/8/24.
//

import Foundation

public struct Certification: Codable {
  var id: UInt
  var name: String
  var certNumber: String?
  var issueDate: String?
  var expirationDate: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case certNumber = "cert_number"
    case issueDate = "issue_date"
    case expirationDate = "expiration_date"
  }
}

public struct User: Codable {
  var id: UInt
  var type: String
  var firstName: String
  var lastName: String
  var email: String?
  var login: String
  var phone: String?
  var createdAt: String
  var currentCertifications: [Certification]?
  var lastActive: String?
  var link: String?
  var magicLink: String?
  
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
  var link: String?
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
