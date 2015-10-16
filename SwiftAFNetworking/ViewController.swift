//
//  ViewController.swift
//  SwiftAFNetworking
//
//  Created by MMizogaki on 10/14/15.
//  Copyright © 2015 [MMasahito](https://github.com/MMasahito). All rights reserved.
//

import UIKit
import AFNetworking
import AFNetworkActivityLogger

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** Request header, response header also log output */
        AFNetworkActivityLogger.sharedLogger().startLogging()
        AFNetworkActivityLogger.sharedLogger().level = .AFLoggerLevelDebug
        
        /** manager */
        let manager:AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
        let serializer:AFJSONRequestSerializer = AFJSONRequestSerializer()
        let param = ["format":"json"]
        manager.requestSerializer = serializer
        
        
        
        
        let jsonUrl:String! = "http://www.raywenderlich.com/demos/weather_sample/weather.php"
        
        /** GET */
        manager.GET(jsonUrl, parameters: param,
            success: {(operation: AFHTTPRequestOperation!, responsobject: AnyObject!) in
                print("Success!!")
                print(responsobject)
            },
            failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                print("Error!!")
            }
        )
        
        
        /** POST */
        manager.POST(jsonUrl, parameters: param,
            success: { (operation: AFHTTPRequestOperation!, responseObject:AnyObject!) in
                print("response: \(responseObject)")
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                print("Error: \(error)")
        })
        
        
        
        /** afnetworking upload images */
        let image1:UIImage = UIImage(named:"my_image")!
        let image2:UIImage = UIImage(named:"my_image")!
        let parameters: Dictionary<String,AnyObject> = ["key1": "value1", "key2": "value2"] // Param
        let images: Dictionary<String,UIImage> = ["image1":image1, "image2":image2] // imageData
        
        /** Basic authentication */
        let user = "user"
        let pass = "pass"
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(user, password: pass)
        manager.POST(jsonUrl, parameters: parameters, constructingBodyWithBlock: { (data) in
            
            for (key, value) in images {
                let name = key
                let imageData = NSData(data: UIImageJPEGRepresentation(value, 1)!)
                data.appendPartWithFileData(imageData, name: name, fileName: name, mimeType: "image/jpeg")
            }
            
            }, success: { (operation: AFHTTPRequestOperation!, responsobject: AnyObject!) in
                print("response: \(responsobject)")
            }, failure: { (operation, error) in
                print("Error: \(error)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

