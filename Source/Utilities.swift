// Copyright © 2016 Venture Media Labs. All rights reserved.
//
// This file is part of BrainCore. The full BrainCore copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Metal
import Upsurge

public func unsafeBufferPointerFromBuffer(buffer: MTLBuffer) -> UnsafeMutableBufferPointer<Float> {
    let pointer = UnsafeMutablePointer<Float>(buffer.contents())
    let count = buffer.length / sizeof(Float)
    return UnsafeMutableBufferPointer(start: pointer, count: count)
}

public func arrayFromBuffer(buffer: MTLBuffer, start: Int = 0) -> Array<Float> {
    let pointer = UnsafePointer<Float>(buffer.contents()) + start
    let count = buffer.length / sizeof(Float) - start
    return Array<Float>(UnsafeBufferPointer(start: pointer, count: count))
}

public func valueArrayFromBuffer(buffer: MTLBuffer, start: Int = 0) -> ValueArray<Float> {
    let pointer = UnsafeMutablePointer<Float>(buffer.contents()) + start
    let count = buffer.length / sizeof(Float) - start
    var array = ValueArray<Float>(count: count)
    withPointer(&array) { $0.assignFrom(pointer, count: count) }
    return array
}

public func fillBuffer<Collection: CollectionType where Collection.Generator.Element == Float>(buffer: MTLBuffer, start: Int, withElements elements: Collection) {
    let pointer = UnsafeMutablePointer<Float>(buffer.contents()) + start
    for (i, v) in elements.enumerate() {
        pointer[i] = v
    }
}
