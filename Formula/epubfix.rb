require "etc"

class Epubfix < Formula
  desc "A CLI tool to fix and repair EPUB files"
  homepage "https://github.com/tohnk/epubfix"
  url "https://github.com/tohnk/epubfix/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "4e016b5fed445f1b1c3a53daa4b380a2e55a89fcd235164e9c28f5047728c384"
  license "MIT"

  # Intentionally use the user's existing rustup installation.
  # No depends_on "rust" => :build

  def install
    # Get the account's real home, not Homebrew's temporary HOME.
    real_home = Etc.getpwuid(Process.uid).dir
    cargo_bin = "#{real_home}/.cargo/bin"
    cargo = "#{cargo_bin}/cargo"

    unless File.executable?(cargo)
      odie "Expected rustup's Cargo at #{cargo}, but it is missing or not executable."
    end

    # Tell rustup where the already-installed toolchains live.
    ENV["RUSTUP_HOME"] = "#{real_home}/.rustup"

    # Keep Cargo's downloads, cache and lock files inside the sandbox.
    ENV["CARGO_HOME"] = (buildpath/"cargo-home").to_s

    # Make Rust tools available to Cargo and dependency build scripts.
    ENV.prepend_path "PATH", cargo_bin

    # Explicitly select rustup's compiler as well as its Cargo.
    ENV["RUSTC"] = "#{cargo_bin}/rustc"

    # Show actual errors rather than hiding them behind "Cargo not found".
    system cargo, "--version"
    system "#{cargo_bin}/rustc", "--version"

    # Install into Homebrew's prefix using the existing Rust toolchain.
    system cargo, "install", *std_cargo_args
  end

  test do
    assert_match "epubfix", shell_output("#{bin}/epubfix --help")
  end
end
