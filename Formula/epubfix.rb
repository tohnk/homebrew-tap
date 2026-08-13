class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "65a3838ebfc3bac75ab1f849db995ca370c8e1d3941cbca30050b02bc8cc7ade"
  license "MIT" # Update if your repo uses a different license (e.g. "Apache-2.0")

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # Simple check that the binary executes
    assert_match "epubfix", shell_output("#{bin}/epubfix --help")
  end
end
