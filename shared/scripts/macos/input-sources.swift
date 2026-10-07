import Carbon
import Foundation

func check(_ status: OSStatus) {
  if status != noErr { exit(status) }
}

func inputSourceID(_ source: TISInputSource) -> String? {
  guard let property = TISGetInputSourceProperty(source, kTISPropertyInputSourceID) else {
    return nil
  }

  return Unmanaged<CFString>.fromOpaque(property).takeUnretainedValue() as String
}

func requireInputSource(
  _ id: String,
  in sources: [TISInputSource]
) -> TISInputSource {
  guard let source = sources.first(where: { inputSourceID($0) == id }) else {
    fputs("Input source not found: \(id)\n", stderr)
    exit(EXIT_FAILURE)
  }

  return source
}

let bundle = URL(fileURLWithPath: "/Library/Input Methods/GoogleJapaneseInput.app")
check(TISRegisterInputSource(bundle as CFURL))

let sources = TISCreateInputSourceList(nil, true).takeRetainedValue() as! [TISInputSource]

let enabledInputSourceIDs = [
  "com.apple.keylayout.ABC",
  "com.google.inputmethod.Japanese",
  "com.google.inputmethod.Japanese.Roman",
  "com.google.inputmethod.Japanese.base",
]

for id in enabledInputSourceIDs {
  check(TISEnableInputSource(requireInputSource(id, in: sources)))
}

check(
  TISDisableInputSource(
    requireInputSource("com.apple.inputmethod.Kotoeri.RomajiTyping", in: sources)))
