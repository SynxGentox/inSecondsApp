//
//  DataState.swift
//  inSecondsApp
//
//  Created by Aryan Verma on 27/09/26.
//

import Foundation

enum DataState: Equatable {
    case isLoading
    case isSuccess
    case isError(String)
    case isEmpty
}
