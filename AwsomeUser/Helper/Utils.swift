//
//  Utils.swift
//  AwsomeUser
//
//  Created by Arman Gorj on 11/8/1401 AP.
//

import Foundation
struct Utils {
    public static func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    public static func wait(_ second: Double, _ block: @escaping ()->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + second, execute: block)
    }

    public static func printDocumentDirectory() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
    }
}
