class Arb < Formula
  desc "Arb terminal application"
  homepage "https://github.com/szj2ys/arb"
  version "0.3.1"

  on_macos do
    url "https://api.github.com/repos/szj2ys/arb/releases/assets/356189830"
    sha256 "8dfcd9113401277f1739a3014e29c777e41400e26e9e9ac5eb4ce56c2f7068fa"
    header "Accept: application/octet-stream"
  end

  def install
    # The release asset contains Arb.app at top-level.
    prefix.install Dir["Arb.app"]

    bin.install_symlink prefix/"Arb.app/Contents/MacOS/arb"
    bin.install_symlink prefix/"Arb.app/Contents/MacOS/arb-gui" => "arb-gui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/arb --version")
  end
end
