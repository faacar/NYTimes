//
//  NetworkingError.swift
//  NYTimes
//
//  Created by Ahmet Acar on 23.01.2021.
//

import Foundation

enum NetworkingError: String, Error {
    case connectionProblem = " Network problem. Please try again."
    case unableToComplete = "Unable to complete your request. Plaese check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recived from the server is invalid. Please try again."
}
