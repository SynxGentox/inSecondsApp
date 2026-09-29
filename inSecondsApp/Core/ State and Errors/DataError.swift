//
//  DataError.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation

enum DataError: String, Error, LocalizedError {
    case fileNotFound = "File missing/wrong path"  // File missing or wrong path
    case decodingError = "Decoding Error. Tip: 'Check model dataType.'"  // Invalid JSON file
    case noData = "No data returned"        // Empty JSON/Data
    case cancellationError = "API request denied"       // Request has been cancelled
    
    var errorDescription: String? { rawValue }
}
