import Foundation

typealias WLListnersCallbackBlock = (Any, Any) -> Void

protocol ObserverProtocol {
    var listner: Any? { get set }
    var name: String { get set }
    var informOnceAndAutoRemove: Bool {get set}
    var callback: WLListnersCallbackBlock? {get set}
}

protocol ObservableProtocol {
    func addListner(_ listner: Any, named name: String, block callback: @escaping WLListnersCallbackBlock)
    func addListner(_ listner: Any?, named name: String, once: Bool, block callback: @escaping WLListnersCallbackBlock)
    func removeListner(_ listner: Any?, named name: String)
    func informAllListnersOf(_ obj: Any, result: Any?)
}

// MARK: - WLListnerInfo class

@objc public class WLListnerInfo: NSObject, ObserverProtocol {
    var listner: Any?
    var name = ""
    var informOnceAndAutoRemove = false
    var callback: WLListnersCallbackBlock?

    deinit {
        print("dealloc in \(self)")
    }

    func description() -> String? {
        let strSuperDescription = super.description
        let desc = "\(strSuperDescription) name = '\(name)' once = \(informOnceAndAutoRemove ? "YES" : "NO") listner = \(listner ?? "")"
        return desc
    }
}

// MARK: - WLListners class

@objc public class WLListners: NSObject, ObservableProtocol {

    var listners: [WLListnerInfo] = []

    @objc override public init() {
        super.init()
        listners = [WLListnerInfo]()
    }

    @objc func count() -> Int {
        return self.listners.count
    }

    ///keeps weak reference to the listner. The callback is automatically removed when the listner is released. The name allows add several block to the same listner with different purposes.
    @objc func addListner(_ listner: Any, named name: String, block callback: @escaping WLListnersCallbackBlock) {
        addListner(listner, named: name, once: false, block: callback)
    }

    @objc func addListner(_ listner: Any?, named name: String, once: Bool, block callback: @escaping WLListnersCallbackBlock) {
        removeListner(listner, named: name) //to replace if already added
        let listnerInfo = WLListnerInfo()
        listnerInfo.listner = listner
        listnerInfo.name = name
        listnerInfo.informOnceAndAutoRemove = once
        listnerInfo.callback = callback
        listners.append(listnerInfo)
    }

    @objc func removeListner(_ listner: Any?, named name: String) {
        var i = 0
        while i < listners.count {
            let listnerInfo = listners[i]
            if listnerInfo.listner == nil || ((listner as AnyObject === listnerInfo.listner as AnyObject) && (name.isEmpty || (listnerInfo.name == name))) {
                listners.remove(at: i)
                continue
            }
            i += 1
        }
    }

// MARK: - #SWIFT перепроверить
    @objc public func informAllListnersOf(_ obj: Any, result: Any?) {
        var i = 0
        var listnersCopy: [WLListnerInfo] = []
        while i < listners.count {
            let listner = listners[i]
            if listner.listner == nil || listner.callback == nil {
                listners.remove(at: i) //cleanup: remove outdated listners
            } else {
                //не вызываем сразу callback, т.к. в callback может быть удалён этот listner (и i++ вызывало бы к перепрыгиванию через следующий listner в массиве - он не был бы проинформирован)
                listnersCopy.append(listner)
                i += 1
            }
        }
        for listner in listnersCopy {
            listner.callback!(obj,result!)
        }

        //remove once-fire listners
        i = 0
        while i < listners.count {
            let listner = listners[i]
            if listner.informOnceAndAutoRemove {
                listners.remove(at: i)
            } else {
                i += 1
            }
        }
    }
}

let news = WLListners()
let blogger = WLListnerInfo()
let reporter = WLListnerInfo()

news.addListner(blogger, named: "Blogger") { (obj, result) in
    print("blogger says: obj = \(obj), result = \(result)")
}

news.addListner(reporter, named: "repoter") { (obj, result) in
    print("reporter says: obj = \(obj), result = \(result)")

}

news.informAllListnersOf("dsd", result: "sdds")
