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
//  SpeechProductionImplementation.swift
//  robobo-speech
//
//  Created by Luis Felipe Llamas Luaces on 15/03/2019.
//  Copyright © 2019 mintforpeople. All rights reserved.
//

import robobo_framework_ios_pod
import robobo_remote_control_ios

import AVFoundation
// https://www.appcoda.com/text-to-speech-ios-tutorial/
class SpeechProductionModuleImplementation: NSObject, ISpeechProductionModule, ICommandExecutor{
    
    
    
    var speechUtterance: AVSpeechUtterance!

    func executeCommand(_ c: RemoteCommand, _ rcmodule: IRemoteControlModule) {
        sayText(c.getParameters()["text"]!, .priority_low)
    }
    
    
    
    var manager: RoboboManager!
    
    var remote: IRemoteControlModule!
    
    var delegateManager: SpeechProductionDelegateManager!
    
    
    var speechSynth: AVSpeechSynthesizer!
    var locale:String = "es_ES"
    
    func sayText(_ text: String, _ priority: SpeechPriority) {
    
        speechUtterance = AVSpeechUtterance(string:text)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        speechUtterance.pitchMultiplier = 0.5
        speechUtterance.voice = AVSpeechSynthesisVoice(language: self.locale)
        if ((priority == .priority_high)){
            speechSynth.stopSpeaking(at: AVSpeechBoundary.word)
            
        }
        
        speechSynth.speak(speechUtterance)
        

    }
    
    func startup(_ manager: RoboboManager) throws {
        manager.log("Startup Speech")
        
        self.manager = manager
        
        do {
            let module = try manager.getModuleInstance("IRemoteControlModule")
            remote = module as? IRemoteControlModule
        } catch  {
            print(error)
        }
        
        delegateManager = SpeechProductionDelegateManager(remote)
        speechSynth = AVSpeechSynthesizer()
        speechSynth.delegate = self
        remote.registerCommand("TALK", self)
    }
    
    func shutdown() throws {
    }
    
    func getModuleInfo() -> String {
        return "SpeechProductionModule"
    }
    
    func getModuleVersion() -> String {
        return "v0.1"
    }
    
    func setLanguage(_ language: String) {
        self.locale = language
    }

}



extension SpeechProductionModuleImplementation: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.delegateManager.notifyEndOfSpeech()
    }
}
