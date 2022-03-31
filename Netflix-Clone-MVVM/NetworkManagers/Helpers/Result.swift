//
//  Result.swift
//  Netflix-Clone-MVVM
//
//  Created by ugur-pc on 31.03.2022.
//

import Foundation


public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
