//
//  ViewController.swift
//  robobo-speech-ios
//
//  Created by 623e45d3ebd5e88abf84e2a4f33c4511abb531ad on 05/23/2019.
//  Copyright (c) 2019 623e45d3ebd5e88abf84e2a4f33c4511abb531ad. All rights reserved.
//

import UIKit
import robobo_framework_ios_pod
import robobo_speech_ios

class ViewController: UIViewController, RoboboManagerDelegate {

    var manager : RoboboManager!
    var speechModule :ISpeechProductionModule!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = RoboboManager()
        manager.addFrameworkDelegate(self)
        do{
            try manager.startup()

            let module = try manager.getModuleInstance("ISpeechProductionModule")
            speechModule = module as? ISpeechProductionModule
        }catch{
            print(error)
        }
        
        speechModule.sayText("Hola mundo")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadingModule(_ moduleInfo: String, _ moduleVersion: String) {
        self.manager.log("Loading \(moduleInfo) \(moduleVersion)",LogLevel.VERBOSE)
        
    }
    
    func moduleLoaded(_ moduleInfo: String, _ moduleVersion: String) {
        self.manager.log("Loaded \(moduleInfo) \(moduleVersion)", LogLevel.INFO)
    }
    
    func frameworkStateChanged(_ state: RoboboManagerState) {
        self.manager.log("Framework state changed: \(state)")
    }
    
    func frameworkError(_ error: Error) {
        self.manager.log("Framework error: \(error)", LogLevel.WARNING)
    }
}

