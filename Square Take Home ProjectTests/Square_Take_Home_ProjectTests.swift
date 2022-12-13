//
//  Square_Take_Home_ProjectUITests.swift
//  Square Take Home ProjectUITests
//
//  Created by TizzyMatic on 12/12/22.
//

import XCTest
@testable import Square_Take_Home_Project

final class Square_Take_Home_ProjectUITests: XCTestCase {

    func testEmployeesCodable() throws {
        let expected = [Employee(uuid: "2192206e-05c6-4118-a82f-e51762f06a5e", fullName: "Tony Montana", phoneNumber: "444-444-4444", emailAddress: "tonymontana@gmail.com", biography: "Vestibulum varius justo et dui suscipit tempus. Etiam a arcu eget augue semper facilisis eget non mauris. Integer malesuada lectus et massa efficitur, ut lacinia quam condimentum.", smallPhotoUrl: "https://avatars.githubusercontent.com/u/19754084?v=4", largePhotoUrl: "https://avatars.githubusercontent.com/u/19754084?v=4", teamName: "Cavs", employeeType: "FULL_TIME")]
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try encoder.encode(expected)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode([Employee].self, from: encoded)
        
        XCTAssertEqual(decoded, expected)
    }
    
    func testEmployeeCodable() throws {
        let expected = Employee(uuid: "2192206e-05c6-4118-a82f-e51762f06a5e", fullName: "Tony Montana", phoneNumber: "444-444-4444", emailAddress: "tonymontana@gmail.com", biography: "Vestibulum varius justo et dui suscipit tempus. Etiam a arcu eget augue semper facilisis eget non mauris. Integer malesuada lectus et massa efficitur, ut lacinia quam condimentum.", smallPhotoUrl: "https://avatars.githubusercontent.com/u/19754084?v=4", largePhotoUrl: "https://avatars.githubusercontent.com/u/19754084?v=4", teamName: "Lakers", employeeType: "Contractor")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encoded = try encoder.encode(expected)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(Employee.self, from: encoded)
        
        XCTAssertEqual(decoded, expected)
    }
}
