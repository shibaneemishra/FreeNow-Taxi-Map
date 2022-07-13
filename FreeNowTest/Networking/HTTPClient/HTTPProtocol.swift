//
//  HTTPProtocol.swift
//  FreeNowTest
//
//  Created by Shibanee Mishra on 08/07/22.
//

import Foundation

protocol RequestProtocol {
    var URL: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var queryParams: [String: String]? { get }
}


extension RequestProtocol{
    func request() -> URLRequest{
        let url = URL
        guard var urlComponent = URLComponents(string: url) else {
            fatalError("Unable to create url component")
        }
        var queryItem = [URLQueryItem]()
        for (key, value) in queryParams ?? [String: String](){
            queryItem.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        urlComponent.queryItems = queryItem
        
        var urlRequest =
            URLRequest(url: urlComponent.url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: NetworkConstants.Service.timeInterval)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        //print(try? JSONSerialization.jsonObject(with: httpBody ?? Data(), options: .mutableLeaves))
        print(URL)
        print("Query Parameters:- ",queryParams ?? "")
        print("Raw Data:-" + String(decoding: httpBody ?? Data(), as: UTF8.self) + "\nHeaders:-")
        urlRequest.allHTTPHeaderFields = HTTPHeader().getHeaders
        print(urlRequest.allHTTPHeaderFields ?? "")
        print(urlRequest.url ?? "")

        return urlRequest
    }
}


//
//protocol URLSessionProtocol {
//    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
//}
//
//extension URLSession: URLSessionProtocol{
//    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
//        let task = dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
//        return task as URLSessionDataTaskProtocol
//    }
//}
