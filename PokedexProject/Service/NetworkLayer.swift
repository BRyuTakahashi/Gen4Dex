//
//  NetworkLayer.swift
//  PokedexProject
//
//  Created by Bruno Ryu Takahashi on 08/07/26.
//

import Foundation

protocol NetworkLayer {
    var session: URLSession { get }
    func request<T: Decodable>(with urlString: String, method: HTTPMethod, DecodeType: T.Type, completion: @escaping(Result<T, NetworkError>) -> Void)
}
