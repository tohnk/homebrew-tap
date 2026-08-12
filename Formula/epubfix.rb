class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "f1ee2bff7b075a8e8840990c6670f4bbd266d95f69972fe22f2b3f82a765fd2d"
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