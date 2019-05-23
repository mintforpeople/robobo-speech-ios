//
//  SpeechProductionDelegateManager.swift
//  robobo-speech
//
//  Created by Luis Felipe Llamas Luaces on 15/03/2019.
//  Copyright © 2019 mintforpeople. All rights reserved.
//

import robobo_framework_ios_pod

public class SpeechProductionDelegateManager: DelegateManager {
    override init() {
        super.init()
    }
    
    func notifyEndOfSpeech(){
        for delegate in delegates{
            if let del = delegate as? ISpeechProductionDelegate{
                del.onEndOfSpeech()
            }
        }
    }
}
