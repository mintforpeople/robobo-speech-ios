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
//  SpeechProductionDelegateManager.swift
//  robobo-speech
//
//  Created by Luis Felipe Llamas Luaces on 15/03/2019.
//  Copyright © 2019 mintforpeople. All rights reserved.
//

import robobo_framework_ios_pod
import robobo_remote_control_ios

public class SpeechProductionDelegateManager: DelegateManager {
    var remote: IRemoteControlModule!
    init(_ remote:IRemoteControlModule) {
        super.init()
        self.remote = remote
    }
    
    func notifyEndOfSpeech(){
        for delegate in delegates{
            if let del = delegate as? ISpeechProductionDelegate{
                del.onEndOfSpeech()
            }
        }
        
        let s:Status = Status("UNLOCK-TALK")
        
        
        remote.postStatus(s)
    }
}
