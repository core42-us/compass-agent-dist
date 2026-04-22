class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-2951331/compass-darwin-arm64.zip"
  version "source-2951331"
  version_scheme 1
  sha256 "e26190a3fe8a38254c23f16aba47f1248fb12565af4094346ad2040fb480eb32"

  depends_on arch: :arm64
  depends_on :macos
  depends_on "ripgrep" => :recommended

  def install
    bin.install "compass-darwin-arm64" => "compass"
    bin.install "compass-tui"
    bin.install "compass-agent"
    bin.install "compass-server"
    bin.install "compass-bridge"
    pkgshare.install "compass-chat.vsix"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/compass version")
    assert_match "compass bridge", shell_output("#{bin}/compass bridge")
    assert_predicate pkgshare/"compass-chat.vsix", :exist?
  end
end
