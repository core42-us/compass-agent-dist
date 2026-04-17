class Compass < Formula
  desc "Local-first coding assistant for repo-aware developer workflows"
  homepage "https://github.com/core42-us/compass-agent-dist"
  url "https://github.com/core42-us/compass-agent-dist/releases/download/source-920124c/compass-darwin-arm64.zip"
  version "source-920124c"
  sha256 "39bda44a656580bad8927a9635ce1db05f9e6cfb88a7616d55e61ba8ccf7859a"

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
