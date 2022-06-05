//
//  ViewController.swift
//  swift-pretty-log-demo
//
//  Created by Paolo Prodossimo Lopes on 05/06/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LOG.DEBUG(.API(.success("API - Success")))
        LOG.DEBUG(.API(.failure("API - Error")))
        LOG.DEBUG(.ERROR("Error"))
        LOG.DEBUG(.WARNING("Warning"))
        LOG.DEBUG(.TODO("Todo"))
        LOG.DEBUG(.SUCCESS("Success"))
        LOG.DEBUG(.ln("other"))
        
        LOG.DEBUG(.SUCCESS("Variant 1"), style: .abreviate)
        LOG.DEBUG(.SUCCESS("Variant 2"), style: .complete)
    }
}

