class Arb < Formula
  desc "Arb terminal application"
  homepage "https://github.com/szj2ys/arb"
  version "0.3.1"

  on_macos do
    url "https://api.github.com/repos/szj2ys/arb/releases/assets/356191765"
    sha256 "8dfcd9113401277f1739a3014e29c777e41400e26e9e9ac5eb4ce56c2f7068fa"
  end

  # Homebrew formulas support specifying the download strategy class directly.
  # This is required here because GitHub web release URLs return 404 in this
  # environment, so we fetch the asset via the API.
  download_strategy ArbGitHubReleaseAssetDownloadStrategy

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

class ArbGitHubReleaseAssetDownloadStrategy < CurlDownloadStrategy
  def curl_args
    args = super
    args << "-H" << "Accept: application/octet-stream"

    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    token ||= ENV["GITHUB_TOKEN"]
    token ||= ENV["GH_TOKEN"]
    args << "-H" << "Authorization: Bearer #{token}" if token && !token.empty?
    args
  end

  def fetch(*args, **kwargs)
    ENV["HOMEBREW_GITHUB_API_TOKEN"] ||= ENV["GITHUB_TOKEN"] || ENV["GH_TOKEN"]
    super
  end
end
