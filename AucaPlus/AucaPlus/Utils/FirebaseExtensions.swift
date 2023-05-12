//
//  FirebaseExtensions.swift
//  AucaPlus
//
//  Created by Cédric Bahirwe on 12/05/2023.
//

import FirebaseFunctions
import FirebaseFirestore

struct FunctionsTest {
    private var functions = Functions.functions()
    static let shared = FunctionsTest()
    private init() {
        functions.useEmulator(withHost: "localhost", port: 5001)

    }
    
    func test() async {
        
        
        let item = SignupRequestBody.testBody2.convertToDictionary()
        print("Sending item:", item)
        
        var request = URLRequest(url: URL(string: "http://localhost:5001/auca-plus/us-central1/api/signup")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    
        do {
            let jsonData = try JSONEncoder().encode(item)
            request.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            print("I believed", (response as? HTTPURLResponse)?.statusCode)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let profile = json["profile"] as? Bool {
                    print("User exists: \(profile)")
                } else {
                    print("Could note deduce", json)
                }
            }
        } catch {
            print("Fucntion", error.localizedDescription)
        }

        
        
//        do {
//            let result = try await functions.httpsCallable("api/signup")
//                .call(item)
//            if let data = result.data as? [String:Any] {
//                print("Final data:", data)
//            } else {
//                print("Could not decode result", result)
//            }
//        }
//        catch {
//            print("Function : ", error, error.localizedDescription)
//        }
    }
    
    func test1() async {
        
        var request = URLRequest(url: URL(string: "http://localhost:5001/auca-plus/us-central1/api/hasProfile")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let phoneNumber = "+16505553434"
        let parameters: [String: String] = ["phoneNumber": phoneNumber]

        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            print(error.localizedDescription)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let profile = json["profile"] as? Bool {
                    print("Profile exists: \(profile)")
                } else {
                    print("Could note deduce", json)
                }
            }
        } catch {
            print("Fucntion", error.localizedDescription)
        }

        
//        do {
//            let result = try await functions.httpsCallable("api/hasProfile")
//
//                .call(["phoneNumber" : "+16505553434"])
//            if let data = result.data as? [String:Any] {
//                print("Final data:", data)
//            } else {
//                print("Could not decode result", result)
//            }
//        }
//        catch {
//            print("Function : ", error, error.localizedDescription)
//        }
    }
    
    struct SignupRequestBody {
        let userId: String
        let userHandle: String
        let userFirstName: String?
        let userLastName: String?
        let userAbout: String?
        let phoneNumber: String
        
        static let testBody1 = SignupRequestBody(
            userId: UUID.init().uuidString,
            userHandle: "johndoe",
            userFirstName: "John",
            userLastName: "Doe",
            userAbout: "I'm a software developer",
            phoneNumber: "+250782628511"
        )
        
        static let testBody2 = SignupRequestBody(
            userId: UUID.init().uuidString,
            userHandle: "jane.smith",
            userFirstName: "Jane",
            userLastName: "Smith",
            userAbout: "I'm a graphic designer",
            phoneNumber: "+250782628510"
        )
        
        func convertToDictionary() -> [String: String] {
            let requestBody: SignupRequestBody = self
            var dictionary = [
                "userId": requestBody.userId,
                "userHandle": requestBody.userHandle,
                "phoneNumber": requestBody.phoneNumber
            ]
            
            if let userFirstName = requestBody.userFirstName {
                dictionary["userFirstName"] = userFirstName
            }
            
            if let userLastName = requestBody.userLastName {
                dictionary["userLastName"] = userLastName
            }
            
            if let userAbout = requestBody.userAbout {
                dictionary["userAbout"] = userAbout
            }
            
            return dictionary
        }

    }
    
    
    
}
