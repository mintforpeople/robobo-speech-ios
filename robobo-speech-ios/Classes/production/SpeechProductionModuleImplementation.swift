//
//  SpeechProductionImplementation.swift
//  robobo-speech
//
//  Created by Luis Felipe Llamas Luaces on 15/03/2019.
//  Copyright © 2019 mintforpeople. All rights reserved.
//

import robobo_framework_ios_pod
import AVFoundation
// https://www.appcoda.com/text-to-speech-ios-tutorial/
class SpeechProductionModuleImplementation: NSObject,ISpeechProductionModule{
    
    
  
    
    var delegateManager: SpeechProductionDelegateManager!
    
    var speechUtterance: AVSpeechUtterance!
    var speechSynth: AVSpeechSynthesizer!
    var locale:String = "es_ES"
    
    func sayText(_ text: String) {
        speechUtterance = AVSpeechUtterance(string:text)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 4.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "es_ES")
        speechSynth.speak(speechUtterance)

    }
    
    func startup(_ manager: RoboboManager) throws {
        manager.log("Startup Speech")
        delegateManager = SpeechProductionDelegateManager()
        speechSynth = AVSpeechSynthesizer()
        speechSynth.delegate = self
    }
    
    func shutdown() throws {
    }
    
    func getModuleInfo() -> String {
        return "SpeechProductionModule"
    }
    
    func getModuleVersion() -> String {
        return "v0.1"
    }
    

}

extension SpeechProductionModuleImplementation: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.delegateManager.notifyEndOfSpeech()
    }
}
