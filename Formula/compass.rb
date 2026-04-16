class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-025c0f6/compass-darwin-arm64.zip"
  version "source-025c0f6"
  sha256 "4e15e8557a44005a1d46adaa572e46f65d0a9e00f146761c939bbd3c96cee49e"

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
