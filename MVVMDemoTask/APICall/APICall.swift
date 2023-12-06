//
//  APICall.swift
//  MVVMDemoTask
//
//  Created by Akash Jain on 01/11/23.
//
import UIKit

final class APIManager{
    static let shared = APIManager()
    private init() {}
    
    func loginApi(username:String,password:String, completion: @escaping (Login?,String?)->())
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "test2.unitedpharmacy.sa"
        components.path = "/mobikulhttp/customer/logIn"
        
        components.queryItems = [
            URLQueryItem(name: "websiteId", value: "1"),
            URLQueryItem(name: "username", value: username),
            URLQueryItem(name: "password", value: password),
            URLQueryItem(name: "storeId", value: "1"),
            URLQueryItem(name: "quoteId", value: "0"),
            URLQueryItem(name: "mFactor", value: "2.625"),
            URLQueryItem(name: "currency", value: "SAR")
        ]
        
        guard let url  = components.url else {
            print("Unable to convert URl")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("sha256", forHTTPHeaderField: "apiAuthType")
        request.addValue("6ac14c3c629d9d59e0cd4a3892fec1204e405151c2ad2118132ba91b1fc6d44f", forHTTPHeaderField: "authKey")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { resData, resStatus, resError in
            print(url)
            guard let data = resData,resError == nil else {
                completion(nil,resError?.localizedDescription)
                return
            }
            guard let res = resStatus as? HTTPURLResponse,(200...299) ~= res.statusCode  else {
                completion(nil,"Invalid Request")
                return
            }
            
            do{
                let loginData = try JSONDecoder().decode(Login.self, from: data)
                print(loginData)
                completion(loginData,nil)
            }catch{
                completion(nil,error.localizedDescription)
            }
        }
        task.resume()
        
    }
}


