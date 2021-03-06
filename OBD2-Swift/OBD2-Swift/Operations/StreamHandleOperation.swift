//
//  StreamHandleOperation.swift
//  OBD2Swift
//
//  Created by Sergiy Loza on 30.05.17.
//  Copyright © 2017 Lemberg. All rights reserved.
//

import Foundation

class StreamHandleOperation: Operation, StreamDelegate {
    
    private(set) var input:InputStream
    private(set) var output:OutputStream
    
    var error:Error? {
        didSet {
            input.remove(from: .current, forMode: .defaultRunLoopMode)
            output.remove(from: .current, forMode: .defaultRunLoopMode)
        }
    }
    
    init(inputStream: InputStream, outputStream: OutputStream) {
        self.input = inputStream
        self.output = outputStream
       
    }
    
    override func main() {
        super.main()

        if isCancelled {
            return
        }
        
        self.input.delegate = self
        self.output.delegate = self

        input.schedule(in: .current, forMode: .defaultRunLoopMode)
        output.schedule(in: .current, forMode: .defaultRunLoopMode)
        execute()
        RunLoop.current.run()
    }
    
    func execute() {
        
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        if aStream == input {
            inputStremEvent(event: eventCode)
        } else if aStream == output {
            outputStremEvent(event: eventCode)
        }
        if eventCode == .errorOccurred {
            self.error = aStream.streamError
        }
    }
    
    func inputStremEvent(event: Stream.Event) {
        
    }
    
    func outputStremEvent(event: Stream.Event) {
        
    }
}
