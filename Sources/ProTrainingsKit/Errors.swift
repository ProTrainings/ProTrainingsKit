//
//  File.swift
//  
//
//  Created by Tim Bugai on 5/22/24.
//

import Foundation

public enum ProTrainingsAPIError : Error, Equatable {
  case userAlreadyExists
  case userNotFound
  case invalidData
  case jsonEncoding
  case jsonDecoding
  case unknown(code: Int)
}

extension ProTrainingsAPIError : CustomStringConvertible {
  public var description: String {
    switch(self) {
    case .userAlreadyExists:
      return "The user already exists"
    case .userNotFound:
      return "The requested user was not found"
    case .invalidData:
      return "Data is missing or invalid"
    case .jsonDecoding:
      return "Error decoding response JSON"
    case .jsonEncoding:
      return "Error encoding payload JSON"
    case .unknown(_):
      return "An unknown error occured..."
    }
  }
}

extension ProTrainingsAPIError : LocalizedError {
  public var errorDescription: String? {
    switch(self) {
    case .userAlreadyExists:
      return NSLocalizedString("The user already exists in the system.", comment: "User Already Exists")
    case .userNotFound:
      return NSLocalizedString("The requested user does not exist in the system.", comment: "User Not Found")
    case .invalidData:
      return NSLocalizedString("The data provided is incomplete or invalid", comment: "Invalid Data")
    case .jsonDecoding:
      return NSLocalizedString("Unable to decode server response as JSON", comment: "JSON Decoding")
    case .jsonEncoding:
      return NSLocalizedString("Unable to encode data to JSON to send to server", comment: "JSON Encoding")
    case .unknown(_):
      return NSLocalizedString("An unknown error occured", comment: "Unknown Error")
    }
  }
}
