class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-c64b2ba/compass-darwin-arm64.zip"
  version "source-c64b2ba"
  sha256 "63415fda2f116d29d303be6cf2914334d2a1d51d060ebc624df345fbaa13ead5"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "ripgrep" => :recommended

  def install
    bin.install "compass-darwin-arm64" => "compass"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/compass version")
  end
end
