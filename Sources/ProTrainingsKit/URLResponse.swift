//
//  File.swift
//  
//
//  Created by Tim Bugai on 5/8/24.
//

import Foundation

extension URLResponse {
  func getStatusCode() -> Int? {
    if let httpResponse = self as? HTTPURLResponse {
      return httpResponse.statusCode
    }
    return nil
  }
}
