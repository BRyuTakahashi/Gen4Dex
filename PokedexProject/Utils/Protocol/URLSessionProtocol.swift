//
//  UrlSessionProtocol.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 16/09/26.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}
