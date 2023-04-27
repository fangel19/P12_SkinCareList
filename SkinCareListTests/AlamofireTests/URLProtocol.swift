//
//  URLProtocol.swift
//  SkinCareListTests
//
//  Created by angelique fourny on 23/04/2023.
//

import XCTest
@testable import SkinCareList

final class URLTest: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool { return true }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { return request }
    
    static var loadingHandler: ((URLRequest) -> (HTTPURLResponse, Data?, Error?))?
    
    override func startLoading() {
        guard let handler = URLTest.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (response, data, _) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            class ProtocolError: Error {}
            let protocoleError = ProtocolError()
            client?.urlProtocol(self, didFailWithError: protocoleError)
        }
    }
    override func stopLoading() {}
}
