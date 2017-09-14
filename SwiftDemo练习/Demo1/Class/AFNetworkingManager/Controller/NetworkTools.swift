//
//  NetworkTools.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/29.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit
import AFNetworking
enum RequestType : String {
    case GET = "GET"
    case Post = "POST"
}

class NetworkTools: AFHTTPSessionManager {

    //单例
    static let shareInstance : NetworkTools = {
        
        let tools = NetworkTools()
        let set  = NSSet(array: ["application/json", "text/json", "text/javascript","text/html","text/plain","text/xml"])
        //这是给JSON序列化加一个格式
        tools.responseSerializer.acceptableContentTypes = set as? Set<String>
        let cerPath = Bundle.main.path(forResource: "zz.oricg.com", ofType: "cer")
        let cerData = NSData.init(contentsOfFile: cerPath!)
        let policy = AFSecurityPolicy(pinningMode: .certificate)
        policy.allowInvalidCertificates = true
        policy.validatesDomainName = false
        policy.pinnedCertificates = NSSet(object: cerData ?? "") as? Set<Data>
        tools.securityPolicy = policy
        
        return tools
        
    }()
    
    
    
}


extension NetworkTools {
    
    func request(methodType : RequestType , urlString : String,parameters :[String : Any],failure :@escaping (_ result : Any? , _ error : Error?) -> ()){
        
        let successCallBack = { (stak : URLSessionDataTask ,result : Any?) -> Void in
            
            failure(result, nil)
            
        }
        
        let failureCallBack = {(stak : URLSessionDataTask? ,error : Error?) -> Void in
            //把闭包传出去
            failure(nil, error)
        
        }
        
        //3.判断是那种请求 GET 发送请求 
        if methodType == .GET{
            self.get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            self.post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
       
        
    }
    
}



