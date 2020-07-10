//
//  ConnectionCheck.swift
//  Jet2
//
//  Created by Rahul Varma on 10/07/20.
//  Copyright © 2020 Rahul Varma. All rights reserved.
//

import Foundation
import Network

class ConnectionCheck {
    
    static let shared = ConnectionCheck()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isConneted: Bool = true
    
    private init(){
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    func startMonitoring() {
            self.monitor.pathUpdateHandler = { path in
                self.isConneted = path.status == .satisfied
            }
        }
//
//        func stopMonitoring() {
//            self.monitor.cancel()
//        }
//
//        func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
//            if path.usesInterfaceType(.wifi) {
//                return .wifi
//            } else if path.usesInterfaceType(.wiredEthernet) {
//                return .ethernet
//            } else if path.usesInterfaceType(.cellular) {
//                return .cellular
//            }
//
//            return .unknown
//        }
    
}
