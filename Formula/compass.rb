class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-c53ff4c/compass-darwin-arm64.zip"
  version "source-c53ff4c"
  sha256 "caceb80b3da3f5f424a74d1de3539c47a170816373eea867f84522d0619fadd0"

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
