class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-449d375/compass-darwin-arm64.zip"
  version "source-449d375"
  sha256 "768aec3bf4d497f047fce98d5cdb16b6791486489a40fb985d76ee9486e0b4c4"

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
