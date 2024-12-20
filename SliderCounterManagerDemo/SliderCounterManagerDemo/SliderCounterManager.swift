//
//  Untitled.swift
//  SliderCounterManagerDemo
//
//  Created by 王杰 on 2024/12/20.
//
import UIKit

protocol SliderCounterManagerDelegate: AnyObject {
    func counterManager(didUpdateValue value: Float)
    func counterManager(didChangeState state: SliderCounterManager.State)
}

class SliderCounterManager {
    enum State {
        case running
        case paused
        case stopped
    }

    weak var delegate: SliderCounterManagerDelegate?

    private var timer: Timer?
    private var currentValue: Float = 0
    private let maxValue: Float
    private let interval: TimeInterval

    private(set) var state: State = .stopped {
        didSet {
            delegate?.counterManager(didChangeState: state)
        }
    }

    init(maxValue: Float, interval: TimeInterval) {
        self.maxValue = maxValue
        self.interval = interval
    }

    func start() {
        guard state != .running else { return }
        state = .running
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(updateValue), userInfo: nil, repeats: true)
    }

    func pause() {
        guard state == .running else { return }
        state = .paused
        timer?.invalidate()
    }

    func stop() {
        state = .stopped
        timer?.invalidate()
        currentValue = 0
        delegate?.counterManager(didUpdateValue: currentValue)
    }

    func updateValueManually(to value: Float) {
        currentValue = min(value, maxValue)
        delegate?.counterManager(didUpdateValue: currentValue)
    }

    @objc private func updateValue() {
        currentValue += 1
        if currentValue > maxValue {
            currentValue = 0
        }
        delegate?.counterManager(didUpdateValue: currentValue)
    }
}


