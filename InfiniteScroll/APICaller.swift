//
//  APICaller.swift
//  InfiniteScroll
//
//  Created by Николай Петров on 19.04.2022.
//

import Foundation


class APICaller {
    
    var isPaginating = false
    
    func fetcData(pagination: Bool = false, comletion: @escaping (Result<[String], Error>) -> Void) {
        
        if pagination {
            isPaginating = true
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) { [weak self] in
            guard let self = self else { return }
            let originalData = ["sdfsd",
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
            
            if pagination {
                self.isPaginating = false
            }
        }
    }
}
