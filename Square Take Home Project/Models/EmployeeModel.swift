import Foundation

/// JSON Model based on JSON Endpoint data
struct Employees: Codable {
    var employees: [Employee]
}

struct Employee: Codable, Hashable {
    var uuid:String
    var fullName:String
    var phoneNumber: String?
    var emailAddress:String
    var biography:String?
    var smallPhotoUrl:String?
    var largePhotoUrl:String?
    var teamName:String
    var employeeType: String
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography = "biography"
        case smallPhotoUrl = "photo_url_small"
        case largePhotoUrl = "photo_url_large"
        case teamName = "team"
        case employeeType = "employee_type"
    }
}

