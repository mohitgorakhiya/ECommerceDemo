//
//  CategoryViewModel.swift
//  E-Commerce Demo
//
//  Created by Mohit Gorakhiya on 1/20/19.
//  Copyright © 2019 Mohit. All rights reserved.
//

import Foundation
import RxSwift

struct CategoryViewModel {
    
    var categoryFetchService: CategoryFetchService
    
    init(_ categoryFetchService: CategoryFetchService) {
        self.categoryFetchService = categoryFetchService
    }
    
    func fetchEcommerceDataFromService() -> Observable<Bool> {
        return self.categoryFetchService.fetchEcommerceDataFromService()
    }
}
