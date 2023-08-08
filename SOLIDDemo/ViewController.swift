//
//  ViewController.swift
//  SOLIDDemo
//
//  Created by Kumaran on 08/08/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
/*
class Handler {
    
    func handle() {
        let data = requestDataToAPI()
        let array = parse(data: data)
        saveToDatabase(array: array)
    }
  
    private func requestDataToAPI() -> Data {
        // Network request and wait the response
    }
    
    private func parseResponse(data: Data) -> [String] {
        // Parse the network response into array
    }
   
    private func saveToDatabase(array: [String]) {
        // Save parsed response into database
    }
}
*/

//MARK: - Single Responsibility Principle

class Handler {
    let apiHandler: NetworkHandler
    let parseHandler: ResponseHandler
    let databaseHandler: DatabaseHandler
    
    init(apiHandler: NetworkHandler, parseHandler: ResponseHandler, dbHandler: DatabaseHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.databaseHandler = dbHandler
    }
    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parseResponse(data: data)
        databaseHandler.saveToDatabase(array: array)
    }
}
class NetworkHandler {
    func requestDataToAPI() -> Data {
        // Network request and wait the response
        return Data()
    }
}
class ResponseHandler {
    func parseResponse(data: Data) -> [String] {
        // Parse the network response into array
        return [String]()
    }
}
class DatabaseHandler {
    func saveToDatabase(array: [String]) {
        // Save parsed response into database
    }
}

/*
class Car {
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
   func printDetails() -> String {
        return "I have \(self.color) color \(self.name)."
    }
}

//class Logger {
//    func printData() {
//        let cars = [Car(name: "BMW", color: "Red"),
//                     Car(name: "Audi", color: "Black")]
//         cars.forEach { car in
//             print(car.printDetails())
//         }
//     }
//}


class Bike {
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    func printDetails() -> String {
        return "I have \(self.name) bike of color \(self.color)."
    }
}
class Logger {
    func printData() {
        let cars = [ Car(name: "BMW", color: "Red"),
                     Car(name: "Audi", color: "Black")]
         cars.forEach { car in
             print(car.printDetails())
         }
        let bikes = [ Bike(name: "Homda CBR", color: "Black"),
                      Bike(name: "Triumph", color: "White")]
        bikes.forEach { bike in
             print(bike.printDetails())
         }
     }
}
 */


//MARK: - Open close Principle(Open/Closed principle)

protocol Printable {
    func printDetails() -> String
}

class Car: Printable {
    
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    func printDetails() -> String {
        return "I have \(self.color) color \(self.name)."
    }
}

class Bike: Printable {
    
    let name: String
    let color: String
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    func printDetails() -> String {
        return "I have \(self.name) bike of color \(self.color)."
    }
}

class Logger {
    func printData() {
        let vehicles: [Printable] = [Car(name: "BMW", color: "Red"),
                                  Car(name: "Audi", color: "Black"),
                            Bike(name: "Honda CBR", color: "Black"),
                              Bike(name: "Triumph", color: "White")]
        vehicles.forEach { vehicle in
            print(vehicle.printDetails())
        }
    }
}


//MARK: - Liskov Substitution Principle

/*
let requestKey: String = "NSURLRequestKey"

// NSError subclass provide additional functionality but don't mess with original class.
class RequestError: NSError {
    var request: NSURLRequest? {
        return self.userInfo[requestKey] as? NSURLRequest
    }
}

// I forcefully fail to fetch data and will return RequestError.
func fetchData(request: NSURLRequest) -> (data: NSData?, error: RequestError?) {
    let userInfo: [String:Any] = [requestKey : request]
    return (nil, RequestError(domain:"DOMAIN", code:0, userInfo: userInfo))
}

func willReturnObjectOrError() -> (object: AnyObject?, error: NSError?) {

    let request = NSURLRequest()
    let result = fetchData(request: request)

    return (result.data, result.error)
}

class DemoForLiskov {
    
    let result = willReturnObjectOrError()
    //RequestError
    if var requestError = result.error as? RequestError {
        requestError.request
    }
}

 */


//MARK:- Interface Segregation Principle (ISP)

//We start with the protocol GestureProtocol with a method didTap.

//protocol GestureProtocol {
//    func didTap()
//}

//After some time, you have to add more gestures to the protocol

/*
protocol GestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

class SuperButton: GestureProtocol {
    func didTap() {
        // Single tap operation
    }
    func didDoubleTap() {
        // double tap operation
    }
    func didLongPress() {
        // long press operation
    }
}
//But if implement Double Tab Button it implement all the action
class DoubleTapButton: GestureProtocol {
    func didTap() {
        // Single tap operation
    }
    func didDoubleTap() {
        // double tap operation
    }
    func didLongPress() {
        // long press operation
    }
}

*/

protocol TapProtocol {
    func didTap()
}
protocol DoubleTapProtocol {
    func didDoubleTap()
}
protocol LongPressProtocol {
    func didLongPress()
}
class SuperButton: TapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        // Single tap operation
    }
func didDoubleTap() {
        // double tap operation
    }
func didLongPress() {
        // long press operation
    }
}
class DoubleTapButton: DoubleTapProtocol {
    func didDoubleTap() {
        // double tap operation
    }
}


//MARK:- Dependency Inversion Principle

/*
class FileSystemManager {
    func save(string: String) {
        // Open a file
        // Save the string in this file
        // Close the file
   }
}
class Handler {
    let fileManager = FilesystemManager()
    func handle(string: String) {
        fileManager.save(string: string)
    }
}
*/

protocol Storage {
    func save(string: String)
}

class FileSystemManager: Storage {
    func save(string: String) {
        // Open a file in read-mode
        // Save the string in this file
        // Close the file
    }
}

class DatabaseManager: Storage {
    func save(string: String) {
        // Connect to the database
        // Execute the query to save the string in a table
        // Close the connection
    }
}

class Handler1 {
    let storage: Storage
    // Storage types
    init(storage: Storage) {
        self.storage = storage
    }
    
    func handle(string: String) {
        storage.save(string: string)
    }
}
