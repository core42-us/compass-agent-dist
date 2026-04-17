class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-ee79e6f/compass-darwin-arm64.zip"
  version "20260417213348.ee79e6f"
  version_scheme 1
  sha256 "39c7e14f14a8722566f59f86e52c4ecd576f760af12a4d1d25b4d3a46f732692"

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
