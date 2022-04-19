//
//  APICaller.swift
//  InfiniteScroll
//
//  Created by Николай Петров on 19.04.2022.
//

import Foundation


class APICaller {
    
    func fetcData(pagination: Bool = false, comletion: @escaping (Result<[String], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {
            let originalData = ["sdfsd",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsd",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsdf",
                        "sdfsd"]
            let newData = ["123123",
                           "123123",
                           "123",
                           "123",
                           "123",
                           "123",
                           "123",
                           "123",
                           "123",]
            comletion(.success(pagination ? newData : originalData))
        }
    }
}
