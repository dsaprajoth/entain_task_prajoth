//
//  TestUtils.swift
//  EntainTaskTests
//
//  Created by Prajoth Dsa on 16/12/2024.
//

@testable import EntainTask
import SwiftUI

struct TestUtils {
    /**
     func
     static func fetchRaceMockResponse() -> NextRacesResponse?
     This function fetches mock json for unit testing view models.
     */
    static func fetchRaceMockResponse() -> NextRacesResponse? {
        if let url = Bundle.main.url(forResource: "mock", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(NextRacesResponse.self, from: data)
                return jsonData
            } catch {
                return nil
            }
        }
        return nil
    }
}
