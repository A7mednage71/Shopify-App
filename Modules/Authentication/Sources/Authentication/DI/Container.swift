//
//  File.swift
//  
//
//  Created by Eyad waleed on 07/07/2026.
//

import Foundation
import Swinject
@MainActor
public final class DIContainer {
    
    public static let shared = DIContainer()
    
    private let assembler: Assembler
    
    private init() {
        assembler = Assembler([
            AuthAssembly()
        ])
    }
    
    public var resolver: Resolver {
        assembler.resolver
    }
}
