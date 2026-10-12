cask "key-switch" do
  version "0.7.1"
  sha256 "2162abaf6d0f3c6f428b073eb41dbf3cecc91a78ffcc57e65877d271245baa85"

  url "https://github.com/andrewkomkov/key-switch/releases/download/v#{version}/KeySwitch.zip"
  name "KeySwitch"
  desc "Keyboard layout switcher that corrects text typed in the wrong layout"
  homepage "https://github.com/andrewkomkov/key-switch"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "KeySwitch.app"

  # The app has no notarization, so Gatekeeper stops a quarantined copy.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/KeySwitch.app"],
        must_succeed: false
  end

  uninstall quit:       "com.andrewkomkov.KeySwitch",
            login_item: "KeySwitch"

  zap trash: [
    "~/Library/Application Support/KeySwitch",
    "~/Library/Preferences/com.andrewkomkov.KeySwitch.plist",
  ]

  caveats <<~EOS
    KeySwitch needs the Accessibility permission:
      System Settings > Privacy & Security > Accessibility
    Open the app again after an upgrade.
  EOS
end
