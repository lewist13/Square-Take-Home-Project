import Foundation
import UIKit

/// UIKit class Network Manager handles fetching, loading, and parsing employee data from JSON Endpoint
class NetworkManager: NSObject {
    
    private(set) var employees: [Employee]
    private var model: Employees = Employees.init(employees: [])
    
    static let shared = NetworkManager()
    let fullEndpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    let malformedEndpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    let emptyEndpoint = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
    
    // MARK: Init
    /// Creates a new instance of employees
    override init() {
        employees = model.employees
    }
    
    /// Adds each employee from JSON Endpoint data
    func addEmployee(newEmployee: Employee) {
        employees.append(newEmployee)
    }
    
    /// Removes all employees from the list
    func clearEmployeeList() {
        employees.removeAll()
    }
   
    /// Fetches JSON Endpoint employee data while handleing loading and parsing
    func fetchEmployeeData(url: String, completionHandler: @escaping ([Employee]?, Error?) -> Void) {
        loadJson(urlString: url) { (result) in
            switch result {
                case .success(let data):
                    self.parseData(jsonData: data, completionHandler: completionHandler)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, error)
            }
        }
    }
    
    /// Loads the JSON Endpoint data and handles errors appropriately
    func loadJson(urlString: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(ErrorMessage.invalidURL))
            return
        }
        
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(ErrorMessage.invalidURL))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(ErrorMessage.invalidResponse))
                return
            }
            
            if let data = data {
                completionHandler(.success(data))
            }
        }
        
        urlSession.resume()
    }
    
    /// Parses and decodes the JSON Endpoint data and handles decoding error
    func parseData(jsonData: Data, completionHandler: @escaping ([Employee]?, Error?) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(Employees.self, from: jsonData)
                        
            completionHandler(decodedData.employees, nil)
        } catch let decodeError {
            completionHandler(nil, decodeError)
        }
    }
}
