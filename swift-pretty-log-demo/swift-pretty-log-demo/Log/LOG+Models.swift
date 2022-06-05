//
//  LOG+Models.swift
//  swift-firebase-analytics
//
//  Created by Paolo Prodossimo Lopes on 04/06/22.
//

extension LOG {
    enum Options {
        case API(State)
        case TODO(String)
        case ERROR(String)
        case WARNING(String)
        case SUCCESS(String)
        case ln(String)
    }
    
    enum Style {
        case `standart`
        case abreviate
        case complete
    }
}

extension LOG.Options {
    enum State {
        case success(String)
        case failure(String)
    }
}
