class Arb < Formula
  desc "Arb terminal application"
  homepage "https://github.com/szj2ys/arb"
  version "0.3.2"

  on_macos do
    url "https://github.com/szj2ys/arb/releases/download/v0.3.2/arb_for_update.zip"
    sha256 "5e7ff294fca591ad0fca394b7ba270b5d6078c276d793d2d7fa278179cc93e2b"
  end

  def install
    prefix.install Dir["Arb.app"]
    bin.install_symlink prefix/"Arb.app/Contents/MacOS/arb"
    bin.install_symlink prefix/"Arb.app/Contents/MacOS/arb-gui" => "arb-gui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arb --version")
  end
end
