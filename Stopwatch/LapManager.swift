import Foundation

protocol LapManaging {
    var laps: [String] { get set }
    var delegate: LapManagerDelegate? { get set }
    func startTimer()
    func stopTimer()
    func resetTimer()
    func continueTimer()
    func addLap()
}

protocol LapManagerDelegate: class {
    func timerElapsedWith(_ time: String)
    func lapAdded()
}


class LapManager: LapManaging {
    var delegate: LapManagerDelegate?
    var laps: [String] = []

    private var timer: Timer?
    private var startDate: Date?

    func startTimer() {
        guard timer == nil else { return }
        let currentDate = Date()
        startDate = currentDate
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
            let elapsedTime = self.getElapsedTimeFrom(startDate: currentDate)
            let timeString = self.createTimeStringFrom(interval: elapsedTime)
            self.delegate?.timerElapsedWith(timeString)
        })
        timer?.fire()
    }

    func continueTimer() {
        guard timer == nil, let currentDate = startDate else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
            let elapsedTime = self.getElapsedTimeFrom(startDate: currentDate)
            let timeString = self.createTimeStringFrom(interval: elapsedTime)
            self.delegate?.timerElapsedWith(timeString)
        })
        timer?.fire()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        laps.removeAll()
        timer?.invalidate()
        startDate = nil
        timer = nil
        delegate?.lapAdded()
    }

    func addLap() {
        if let startDate = startDate {
            let elapsedTime = getElapsedTimeFrom(startDate: startDate)
            let timeString = createTimeStringFrom(interval: elapsedTime)
            laps.append(timeString)
            self.delegate?.lapAdded()
        }
    }

    private func getElapsedTimeFrom(startDate: Date) -> TimeInterval {
        return Date().timeIntervalSince(startDate)
    }


    private func createTimeStringFrom(interval: TimeInterval) -> String {
        let formater = DateFormatter()
        formater.dateFormat = "mm:ss:SS"
        let date = Date(timeIntervalSince1970: interval)
        return formater.string(from: date)
    }
}
