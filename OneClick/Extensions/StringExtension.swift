//
//  StringExtension.swift
//  OneClick
//
//  Created by Aleksey Solovyev on 02.01.2023.
//

import OSAKit


extension String {
    func runScript(_ asAdmin: Bool = false, onComplete: @escaping (_ output: String) -> Void) throws -> Void {
        var source: String = "do shell script \"\(self)\""
        
        if (asAdmin) {
            source += " with prompt \"OneClick\" with administrator privileges"
        }
        
        let process = Process()
        process.arguments = ["-e", source]
        process.launchPath = "/usr/bin/osascript"
        process.standardInput = nil
        
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        
        do {
            try process.run()
        } catch {
            throw OneClickError.ScriptFailed
        }
        
        outputPipe.fileHandleForReading.readabilityHandler = { output in
            if output.availableData.count == 0 {
                output.readabilityHandler = nil
            } else {
                DispatchQueue.main.async {
                    onComplete(String(data: output.availableData, encoding: .utf8)!)
                }
            }
        }
    }
}
