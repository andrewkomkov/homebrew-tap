cask "key-switch" do
  version "0.10.0"
  sha256 "ee712cb6a096c4cd476bd9787e97a2bb5584cca76be207e1c8aeab8abf1e14b5"

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
