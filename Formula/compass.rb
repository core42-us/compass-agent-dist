class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-36d2f82/compass-darwin-arm64.zip"
  version "20260417184540.36d2f82"
  version_scheme 1
  sha256 "da8ebfdfe7eecd99c79b075920eedd69eeef2e93b278a991b3b1583351925d2c"

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
