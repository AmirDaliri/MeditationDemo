//
//  EndPoints.swift
//  MeditationDemo
//
//  Created by Amir Daliri on 3/27/21.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum ApiRouter {
    case getMainData
}

extension ApiRouter: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production,
             .qa,
             .staging:
            return "https://jsonblob.com/api/jsonBlob/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch self {
        case .getMainData:
            return "/a07152f5-775c-11eb-a533-c90b9d55001f"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        /// Helper
        /*
        case .<#reqName#>(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.APIKey])
        */
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


