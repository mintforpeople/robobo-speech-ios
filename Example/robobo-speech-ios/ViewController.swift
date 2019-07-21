/*******************************************************************************
 *
 *   Copyright 2019, Manufactura de Ingenios Tecnológicos S.L. 
 *   <http://www.mintforpeople.com>
 *
 *   Redistribution, modification and use of this software are permitted under
 *   terms of the Apache 2.0 License.
 *
 *   This software is distributed in the hope that it will be useful,
 *   but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND; without even the implied
 *   warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   Apache 2.0 License for more details.
 *
 *   You should have received a copy of the Apache 2.0 License along with    
 *   this software. If not, see <http://www.apache.org/licenses/>.
 *
 ******************************************************************************/
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
import robobo_remote_control_ios

class ViewController: UIViewController, RoboboManagerDelegate {

    var manager : RoboboManager!
    var speechModule :ISpeechProductionModule!
    var remote :IRemoteControlModule!
    var proxy: ProxyTest!
    var text :String = "Los robots del futuro serán inteligentes,o sea, podrán realizar diferentes tareas en plan de forma autónoma. Actualmente, los estudiantes y todos los que quieran estar preparados para este futuro próximo, deberían entender cómo funciona este nuevo tipo de robótica. Por lo tanto, el futuro de la robótica está en la educación."
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = RoboboManager()
        proxy = ProxyTest()
        manager.addFrameworkDelegate(self)
        do{
            try manager.startup()

            var module = try manager.getModuleInstance("ISpeechProductionModule")
            speechModule = module as? ISpeechProductionModule
            
            module = try manager.getModuleInstance("IRemoteControlModule")
            remote = module as? IRemoteControlModule
        }catch{
            print(error)
        }
        
        remote.registerRemoteControlProxy(proxy)
        var args: [String:String] = [:]
        args["text"]=text
        //var c: Command = Command("TALK",0,args)
        //remote.queueCommand(c)
        speechModule.setLanguage("en_US")
        speechModule.sayText("test primero",.priority_low)
        speechModule.sayText(text, .priority_low)
        
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

